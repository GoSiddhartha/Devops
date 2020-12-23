variable "resource_group_name" {
	description = "Name of the ressource group in which the storage account shall reside"
}

variable "location" {
	description = "The Azure Region"
  	default = "West Europe"
}

variable "account_tier" {
	default = "Standard"
}

variable "is_hns_enabled" {
	default = "false"
}

variable "account_replication_type" {
	default = "LRS"
}

variable "storage_name" {
  
}

