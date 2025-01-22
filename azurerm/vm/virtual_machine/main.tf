
data "azurerm_network_interface" "network" {
  name                = var.network_interface_name
  resource_group_name = var.resource_group_name

}


data "azurerm_managed_disk" "os_disk" {
  name                = var.storage_os_disk.name 
  resource_group_name = var.resource_group_name
}


data "azurerm_managed_disk" "data_disk" {
  for_each           = { for disk in var.storage_data_disk : disk.name => disk }
  name                = each.value.name 
  resource_group_name = var.resource_group_name
}

data "azurerm_storage_account" "storage" {

  name                = var.storage_account_name
  resource_group_name = var.storage_account_resource_group
}



# Create virtual machine 
resource "azurerm_virtual_machine" "hadley_resource" {
  name                              = var.name
  location                          = var.location
  resource_group_name               = var.resource_group_name
  network_interface_ids             = [data.azurerm_network_interface.network.id]
  vm_size                           = var.vm_size
  zones                             = var.zones 
  delete_data_disks_on_termination  = var.delete_data_disks_on_termination
  delete_os_disk_on_termination     = var.delete_os_disk_on_termination
  


 
  dynamic "os_profile_windows_config" {
    for_each = var.storage_os_disk.os_type == "Windows" ? [1] : []
    content {
      enable_automatic_upgrades = false
      provision_vm_agent = true
    }
  }

  dynamic "os_profile_linux_config" {
    for_each = var.storage_os_disk.os_type == "Linux" ? [1] : []
    content {
      disable_password_authentication = false
    }
  }

  

  storage_os_disk{

    name              = data.azurerm_managed_disk.os_disk.name
    caching           = var.storage_os_disk.caching
    create_option     = var.storage_os_disk.create_option
    managed_disk_type = var.storage_os_disk.managed_disk_type
    managed_disk_id   = data.azurerm_managed_disk.os_disk.id
    disk_size_gb      = var.storage_os_disk.disk_size_gb
    os_type           = var.storage_os_disk.os_type
    
  }


  dynamic "storage_data_disk" {
    for_each = var.storage_data_disk.name != "" ? [] : []
    content {
      name              = storage_data_disk.value.name
      lun               = storage_data_disk.lun
      caching           = storage_data_disk.caching
      create_option     = storage_data_disk.create_option
      managed_disk_type = storage_data_disk.managed_disk_type
      managed_disk_id   = data.azurerm_managed_disk.data_disk[storage_data_disk.value.name].id
      disk_size_gb      = storage_data_disk.disk_size_gb
    }
  }


  boot_diagnostics {
    enabled       = "true"
    storage_uri   = data.azurerm_storage_account.storage.primary_blob_endpoint
  }
  
  tags = {
    for tag in var.tags:
    tag.key => tag.value
  }

}