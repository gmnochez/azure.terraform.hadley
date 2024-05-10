output "hadley_network_security_rule_id" {
  value = {for k, v in azurerm_network_security_rule.hadley_resource: k => v.id}
}
