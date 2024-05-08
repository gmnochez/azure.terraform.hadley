resource "azurerm_resource_group" "hadley_resource" {
  name     = var.resource_group_name
  location = var.location

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.value.key
      value               = tag.value.value
    }
  }
}
