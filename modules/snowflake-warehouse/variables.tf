variable "warehouse_config" {
  description = "Configuration object for the Snowflake warehouse"
  type = object({
    name                      = string
    warehouse_size            = optional(string, "X-SMALL")
    warehouse_type            = optional(string, "STANDARD")
    auto_resume               = optional(bool, true)
    auto_suspend              = optional(number, 60)
    initially_suspended       = optional(bool, true)
    min_cluster_count         = optional(number, 1)
    max_cluster_count         = optional(number, 1)
    scaling_policy            = optional(string, "STANDARD")
    enable_query_acceleration = optional(bool, false)
    comment                   = optional(string, null)
  })

  validation {
    condition     = length(var.warehouse_config.name) > 0
    error_message = "Warehouse name must not be empty."
  }

  validation {
    condition = contains([
      "X-SMALL", "XSMALL", "SMALL", "MEDIUM", "LARGE",
      "X-LARGE", "XLARGE", "2X-LARGE", "XXLARGE", "X2LARGE",
      "3X-LARGE", "XXXLARGE", "X3LARGE", "4X-LARGE", "X4LARGE",
      "5X-LARGE", "X5LARGE", "6X-LARGE", "X6LARGE"
    ], upper(var.warehouse_config.warehouse_size))
    error_message = "Invalid warehouse_size. Valid values: X-SMALL, SMALL, MEDIUM, LARGE, X-LARGE, 2X-LARGE, 3X-LARGE, 4X-LARGE, 5X-LARGE, 6X-LARGE."
  }

  validation {
    condition     = contains(["STANDARD", "SNOWPARK-OPTIMIZED"], upper(var.warehouse_config.warehouse_type))
    error_message = "Invalid warehouse_type. Valid values: STANDARD, SNOWPARK-OPTIMIZED."
  }

  validation {
    condition     = contains(["STANDARD", "ECONOMY"], upper(var.warehouse_config.scaling_policy))
    error_message = "Invalid scaling_policy. Valid values: STANDARD, ECONOMY."
  }

  validation {
    condition     = var.warehouse_config.auto_suspend >= 0
    error_message = "auto_suspend must be >= 0 seconds."
  }

  validation {
    condition     = var.warehouse_config.min_cluster_count <= var.warehouse_config.max_cluster_count
    error_message = "min_cluster_count must not exceed max_cluster_count."
  }
}
