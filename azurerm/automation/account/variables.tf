
variable "automation_accounts" {
  description = "automation accounts"

  type = map(object({
    name                      = string
    location                  = string
    resource_group_name       = string
    sku_name                  = string
  }))

  default = {}
 
}



