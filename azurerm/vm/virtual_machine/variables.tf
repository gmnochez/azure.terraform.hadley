variable "name" {
  description = "Name"
}

variable "location" {
  description = "Location"
}

variable "resource_group_name" {
  description = "Resource Group Name"
}

variable "network_interface_ids" {
  description = "Network Interface Ids"
}

variable "vm_size" {
  description = "Vm Size"
}

variable "zones" {
  description = "Zones"
}

variable "delete_data_disks_on_termination" {
  description = "Switch delete data disk"
}

variable "delete_os_disk_on_termination" {
  description = "Switch delete os disk"
}

variable "os_profile_windows_config" {
  description = "Os Profile Windows Config"
  type = object({
    enable_automatic_upgrades = bool
    provision_vm_agent = bool
  })
}

variable "os_profile_linux_config" {
  description = "Os Profile Linux Config"
  type = object({
    disable_password_authentication = bool
  })
}

variable "storage_os_disk" {
  description = "Storage Os Disk"
  type = object({
    name              = string
    caching           = string
    create_option     = string
    managed_disk_type = string
    managed_disk_id   = string
    disk_size_gb      = number
    os_type           = string
  })
}

variable "storage_data_disk" {
  description = "Storage Data Disk"
  type = object({
    name              = string
    lun               = string
    caching           = string
    create_option     = string
    managed_disk_type = string
    managed_disk_id   = string
    disk_size_gb      = number
  })
}

variable "boot_diagnostics" {
  description = "Boot Diagnostics"
  type = object({
    enabled           = string
    storage_uri       = string
  })
}


variable "tags" {
  description = "Lista de Tags"
  type = list(any)
  default = []
}



