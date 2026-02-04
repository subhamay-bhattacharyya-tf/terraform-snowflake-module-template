# Example: Snowflake Warehouse Module Usage
#
# This example demonstrates how to use the snowflake-warehouse module
# to create a Snowflake warehouse with custom configuration.

module "warehouse" {
  source = "../../modules/snowflake-warehouse"

  warehouse_config = {
    name                      = "SN_TEST_STREAMLIT_WH"
    warehouse_size            = "X-SMALL"
    warehouse_type            = "STANDARD"
    auto_resume               = true
    auto_suspend              = 60
    initially_suspended       = true
    min_cluster_count         = 1
    max_cluster_count         = 1
    scaling_policy            = "STANDARD"
    enable_query_acceleration = false
    comment                   = "Test warehouse for Streamlit applications"
  }
}
