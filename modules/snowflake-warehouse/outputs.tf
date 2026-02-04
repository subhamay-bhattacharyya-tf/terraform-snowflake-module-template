output "warehouse_name" {
  description = "The name of the created warehouse"
  value       = snowflake_warehouse.this.name
}

output "warehouse_fully_qualified_name" {
  description = "The fully qualified name of the warehouse"
  value       = snowflake_warehouse.this.fully_qualified_name
}

output "warehouse_size" {
  description = "The size of the warehouse"
  value       = snowflake_warehouse.this.warehouse_size
}

output "warehouse_state" {
  description = "The state of the warehouse (STARTED or SUSPENDED)"
  value       = var.warehouse_config.initially_suspended ? "SUSPENDED" : "STARTED"
}
