


variable "provider_alias" {
  description = "Provider Alias"
}

variable "provider_subscription_id" {
  description = "Provider Subscription ID"
}

variable "private_dns" {
  description = "Private Dns Record"

  type = map(object({
    name                      = string
    zone_name                 = string
    resource_group_name       = string
    ttl                       = string
    records                   = list(string)
  }))
  default = {}
}

variable "tags" {
  description = "Lista de Tags"
  type = list(any)
  default = []
}