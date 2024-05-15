# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0


variable "resource_group_name" {
  description = "Resource group name"
}

variable "name" {
  description = "App AKS cluster name"
}


variable "helm_name" {
  description = "Helm name"
}

variable "helm_repository" {
  description = "Helm repository"
}

variable "helm_chart" {
  description = "Helm chart"
}

variable "helm_file" {
  description = "Helm file"
}

variable "cluster_resource_group_name" {
  description = "Resource Group Storage tfstate"
}

variable "cluster_storage_account_name" {
  description = "Storage Account tfstate"
}
variable "cluster_subscription_id" {
  description = "Subscription tfstate"
}

variable "cluster_storage_key" {
  description = "Key tfstate"
}

    



