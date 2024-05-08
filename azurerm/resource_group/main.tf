resource "azurerm_resource_group" "hadley_resource" {
  name     = var.resource_group_name
  location = var.location

  dynamic "tags" {
    for_each = var.tags
    content {
      name  = tags.value["name_tag"] 
      value = tags.value["value_tag"]
    }
  }
}