// File: test/helpers_test.go
package test

import (
	"crypto/rsa"
	"crypto/x509"
	"database/sql"
	"encoding/pem"
	"fmt"
	"os"
	"strings"
	"testing"

	"github.com/snowflakedb/gosnowflake"
	"github.com/stretchr/testify/require"
)

type WarehouseProps struct {
	Name    string
	Size    string
	Comment string
}

func openSnowflake(t *testing.T) *sql.DB {
	t.Helper()

	orgName := mustEnv(t, "SNOWFLAKE_ORGANIZATION_NAME")
	accountName := mustEnv(t, "SNOWFLAKE_ACCOUNT_NAME")
	user := mustEnv(t, "SNOWFLAKE_USER")
	privateKeyPEM := mustEnv(t, "SNOWFLAKE_PRIVATE_KEY")
	role := os.Getenv("SNOWFLAKE_ROLE")

	// Parse the private key
	block, _ := pem.Decode([]byte(privateKeyPEM))
	require.NotNil(t, block, "Failed to decode PEM block from private key")

	var privateKey *rsa.PrivateKey
	var err error

	// Try PKCS8 first, then PKCS1
	key, err := x509.ParsePKCS8PrivateKey(block.Bytes)
	if err != nil {
		privateKey, err = x509.ParsePKCS1PrivateKey(block.Bytes)
		require.NoError(t, err, "Failed to parse private key")
	} else {
		var ok bool
		privateKey, ok = key.(*rsa.PrivateKey)
		require.True(t, ok, "Private key is not RSA")
	}

	// Build account identifier: orgname-accountname
	account := fmt.Sprintf("%s-%s", orgName, accountName)

	config := gosnowflake.Config{
		Account:       account,
		User:          user,
		Authenticator: gosnowflake.AuthTypeJwt,
		PrivateKey:    privateKey,
	}

	if role != "" {
		config.Role = role
	}

	dsn, err := gosnowflake.DSN(&config)
	require.NoError(t, err, "Failed to build DSN")

	db, err := sql.Open("snowflake", dsn)
	require.NoError(t, err)
	require.NoError(t, db.Ping())
	return db
}

func warehouseExists(t *testing.T, db *sql.DB, warehouseName string) bool {
	t.Helper()

	q := fmt.Sprintf("SHOW WAREHOUSES LIKE '%s';", escapeLike(warehouseName))
	rows, err := db.Query(q)
	require.NoError(t, err)
	defer func() { _ = rows.Close() }()

	return rows.Next()
}

func fetchWarehouseProps(t *testing.T, db *sql.DB, warehouseName string) WarehouseProps {
	t.Helper()

	show := fmt.Sprintf("SHOW WAREHOUSES LIKE '%s';", escapeLike(warehouseName))

	var queryID string
	err := db.QueryRow(show + " SELECT LAST_QUERY_ID();").Scan(&queryID)
	require.NoError(t, err)

	q := fmt.Sprintf(`
		SELECT
			"name"   AS name,
			"size"   AS size,
			"comment" AS comment
		FROM TABLE(RESULT_SCAN('%s'))
		LIMIT 1;
	`, queryID)

	var name, size, comment sql.NullString
	err = db.QueryRow(q).Scan(&name, &size, &comment)
	require.NoError(t, err)

	require.True(t, name.Valid, "Warehouse name not returned from SHOW WAREHOUSES")
	return WarehouseProps{
		Name:    name.String,
		Size:    size.String,
		Comment: comment.String,
	}
}

func mustEnv(t *testing.T, key string) string {
	t.Helper()
	v := strings.TrimSpace(os.Getenv(key))
	require.NotEmpty(t, v, "Missing required environment variable %s", key)
	return v
}

func escapeLike(s string) string {
	return strings.ReplaceAll(s, "'", "''")
}
