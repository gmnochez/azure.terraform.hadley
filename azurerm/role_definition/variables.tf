
variable "name" {
  description = "Role Definition Name"
}

variable "scope" {
  description = "Role Definition Scope"
}

variable "description" {
  description = "Role Definition Description"
}

variable "actions" {
  description = "Actions"
  type = list(string)
  default = []
}


variable "not_actions" {
  description = "Not Actions"
  type = list(string)
  default = []
}

variable "assignable_scopes" {
  description = "Assignable Scopes"
  type = list(string)
  default = []
}



