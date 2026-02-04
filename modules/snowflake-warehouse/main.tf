resource "snowflake_warehouse" "this" {
  name                      = var.warehouse_config.name
  warehouse_size            = var.warehouse_config.warehouse_size
  warehouse_type            = var.warehouse_config.warehouse_type
  auto_resume               = var.warehouse_config.auto_resume
  auto_suspend              = var.warehouse_config.auto_suspend
  initially_suspended       = var.warehouse_config.initially_suspended
  min_cluster_count         = var.warehouse_config.min_cluster_count
  max_cluster_count         = var.warehouse_config.max_cluster_count
  scaling_policy            = var.warehouse_config.scaling_policy
  enable_query_acceleration = var.warehouse_config.enable_query_acceleration
  comment                   = var.warehouse_config.comment
}
