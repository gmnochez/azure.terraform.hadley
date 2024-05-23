variable "management_lock" {
  description = "Management Lock"

  type = map(object({
    scope            = string
    name             = string
    lock_level       = string
    notes            = string
  }))

  default = {}

}

