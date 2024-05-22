
# Create virtual machine 
resource "azurerm_virtual_machine" "ktc-linuxvm" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = var.network_interface_ids
  vm_size               = var.vm_size
  zones                 = var.zones 
  delete_data_disks_on_termination = var.delete_data_disks_on_termination
  delete_os_disk_on_termination    = var.delete_os_disk_on_termination
  


  os_profile_windows_config {
    enable_automatic_upgrades = false
    provision_vm_agent = true
  }
  
  os_profile_linux_config {
    disable_password_authentication = false
  }


  storage_os_disk{

    name              = var.storage_os_disk.name
    caching           = var.storage_os_disk.caching
    create_option     = var.storage_os_disk.create_option
    managed_disk_type = var.storage_os_disk.managed_disk_type
    managed_disk_id   = var.storage_os_disk.managed_disk_id
    disk_size_gb      = var.storage_os_disk.disk_size_gb
    os_type           = var.storage_os_disk.os_type
    
  }

  storage_data_disk {
    name              = var.storage_data_disk.name
    lun               = var.storage_data_disk.lun
    caching           = var.storage_data_disk.caching
    create_option     = var.storage_data_disk.create_option
    managed_disk_type = var.storage_data_disk.managed_disk_type
    managed_disk_id   = var.storage_data_disk.managed_disk_id
    disk_size_gb      = var.storage_data_disk.disk_size_gb
  }

  boot_diagnostics {
    enabled       = var.boot_diagnostics.enabled
    storage_uri   = var.boot_diagnostics.storage_uri
  }
  
  tags = {
    for tag in var.tags:
    tag.key => tag.value
  }

}