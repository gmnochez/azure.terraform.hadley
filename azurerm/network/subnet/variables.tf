

variable "app_subnet_name" {
  description = "App subnet name"
}

variable "app_subnet_address_prefixes" {
  description = "App subnet address prefixes"
  type = set(string)
}

