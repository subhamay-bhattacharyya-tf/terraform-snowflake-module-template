output "warehouse_name" {
  description = "The name of the created warehouse"
  value       = module.warehouse.warehouse_name
}

output "warehouse_fully_qualified_name" {
  description = "The fully qualified name of the warehouse"
  value       = module.warehouse.warehouse_fully_qualified_name
}

output "warehouse_size" {
  description = "The size of the warehouse"
  value       = module.warehouse.warehouse_size
}

output "warehouse_state" {
  description = "The state of the warehouse (STARTED or SUSPENDED)"
  value       = module.warehouse.warehouse_state
}
