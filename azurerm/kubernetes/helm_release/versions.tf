# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 1.28.9"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.1"
    }
  }

  backend "azurerm" {
    use_azuread_auth = false
  }

}
