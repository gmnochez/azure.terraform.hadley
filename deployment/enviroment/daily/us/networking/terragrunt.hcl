include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../resource-group"]
}

terraform {
  source = "${get_parent_terragrunt_dir()}/modules//networking"
}

inputs = {
  main_virtual_network_name          = "ass-dt-eus2-016-vnet-01"
  main_virtual_network_address_space = ["10.116.15.0/24"]
  app_subnet_name                  = "app-subnet"
  app_subnet_address_prefixes      = ["10.116.15.0/25"]
  app_subnet_security_group_name   = "app-subnet-nsg"
  data_subnet_name                  = "data-subnet"
  data_subnet_address_prefixes      = ["10.116.15.0/25"]
  data_subnet_security_group_name   = "data-subnet-nsg"
}
