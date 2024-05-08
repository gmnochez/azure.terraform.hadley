resource "azurerm_resource_group" "hadley_resource" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    for tag in var.tags:
    tag.name_tag = tag.value_tag
    }
}
