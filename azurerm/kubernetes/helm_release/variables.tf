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


