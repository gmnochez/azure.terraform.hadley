variable "name" {
  description = "Manage Disk Name"
}

variable "location" {
  description = "Manage Disk Location"
}

variable "resource_group_name" {
  description = "Manage Disk Resource Group Name"
}

variable "storage_account_type" {
  description = "Manage Disk Storage Account Type"
}

variable "create_option" {
  description = "Manage Disk Create Option"
}

variable "on_demand_bursting_enabled" {
  description = "On Demand Bursting Enabled"
}

 

variable "hyper_v_generation" {
  description = "Manage Disk Hyperv Generation"
}



variable "source_resource_id" {
  description = "Manage Disk Source Resource Id"
}


variable "os_type" {
  description = "Manage Disk Os Type"
}


variable "disk_size_gb" {
  description = "Manage Disk Disk Size Gb"
}

variable "zone" {
  description = "Manage Disk Zone"
}

variable "vm_os_disk_source_name" {
  description = "Manage Disk Source Name"
}


variable "storage_account_name" {
  description = "Storage Account Name"
}

variable "storage_account_resource_group" {
  description = "Storage Account Resource Group"
}


variable "storage_account_blob" {
  description = "Storage Account Blob"
}


variable "platform_image" {
  description = "Platform Image"

  type = object({
    location    = string
    publisher   = string
    offer       = string    
    sku         = string
    version     = string
  })
}


variable "shared_image_version" {
  description = "Shared Image Version"

  type = object({
    name                  = string
    image_name            = string
    gallery_name          = string    
    resource_group_name   = string
  })
}






variable "tags" {
  description = "Lista de Tags"
  type = list(any)
  default = []
}