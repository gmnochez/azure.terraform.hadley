

data "azurerm_storage_account" "storage" {

  name                = var.storage_account_name
  resource_group_name = var.storage_account_resource_group
}


data "azurerm_platform_image" "image" {
  count        = var.platform_image.location == "" ? 0 : 1
  location  = var.platform_image.location
  publisher = var.platform_image.publisher
  offer     = var.platform_image.offer
  sku       = var.platform_image.sku
}


data "azurerm_shared_image_version" "image_version" {
  count        = var.shared_image_version.name == "" ? 0 : 1
  name                = var.shared_image_version.name
  image_name          = var.shared_image_version.image_name
  gallery_name        = var.shared_image_version.gallery_name
  resource_group_name = var.shared_image_version.resource_group_name
}




locals{

  url_os_disk = "${data.azurerm_storage_account.storage.primary_blob_endpoint}${var.storage_account_blob}/${var.vm_os_disk_source_name}"
  
}



resource "azurerm_managed_disk" "hadley_resource" {
  
  name                        = var.name
  location                    = var.location
  resource_group_name         = var.resource_group_name
  storage_account_type        = var.storage_account_type
  create_option               = var.create_option
 
  #Copy
  # storage_account_id   = var.create_option == "Copy" ? data.azurerm_storage_account.storage.id : null 
  source_resource_id          = var.create_option == "Copy" ? var.source_resource_id : null
 
  #Import
  source_uri                  = var.create_option == "Import" ? local.url_os_disk : null 

  #FromImage
  image_reference_id          = var.create_option == "FromImage" ? data.azurerm_platform_image.image.id : null
  gallery_image_reference_id  = var.create_option == "FromImage" ? data.azurerm_platform_image.image.id : null
  
  hyper_v_generation          = var.os_type == "" ? null : var.hyper_v_generation 
  os_type                     = var.os_type == "" ? null : var.os_type
  disk_size_gb                = var.disk_size_gb
  zone                        = var.zone      

  tags = {
    for tag in var.tags:
    tag.key => tag.value
  }

}