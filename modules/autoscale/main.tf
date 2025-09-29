resource "azurerm_monitor_autoscale_setting" "vmss_autoscale" {
  name                = var.autoscale_name
  location            = var.location
  resource_group_name = var.resource_group_name
  target_resource_id  = var.target_resource_id

  profile {
    name = "cpu-autoscale"

    capacity {
      minimum = "1"
      maximum = "5"
      default = "2"
    }

    # Rule: Scale OUT si CPU > 75%
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = var.target_resource_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    # Rule: Scale IN si CPU < 25%
    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = var.target_resource_id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }
  }
}
