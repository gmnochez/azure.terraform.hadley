output "hadley_private_dns_a_record_name" {
  value = {for k, v in azurerm_private_dns_a_record.hadley_resource: k => v.name}
}

output "hadley_private_dns_a_record_id" {
  value = {for k, v in azurerm_private_dns_a_record.hadley_resource: k => v.id}
}
