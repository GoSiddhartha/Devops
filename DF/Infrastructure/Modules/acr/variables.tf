// General Variables
variable "locationcode" {
  default = "azwe"
}

variable "location" {
  default     = "westeurope"
  description = "The Azure Region in which all resources in this example should be provisioned"
}

variable "acr_name" {
  description = "Unique name for the Container Registry"
}

variable "resource_group_name" {
  description = "The name of the resource group in which to place the Container Registry"
}

variable "acrpull_service_principals" {
  type        = list
  default     = []
  description = "All the service principal object ids that require AcrPull access to the Azure Container Registry created"
}

variable "environment" {
  description = "The environment code"
  default     = "d"
}

variable "acr_depends_on" {
  # the value doesn't matter; we're just using this variable
  # to propagate dependencies.
  type    = any
  default = []
}