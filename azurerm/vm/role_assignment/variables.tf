


variable "role_assignment" {
  description = "Role Assignment"

  type = map(object({
    scope                       = string
    role_assignment_id          = string
    role_assignment_name        = string
  }))

  default = {}

}
