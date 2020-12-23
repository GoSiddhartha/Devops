
variable "tenant_id" {
  
}
variable "location" {
  
}
variable "environment" {
  
}
variable "kv_sku_name" {
  default = "standard"
}
variable "account_tier" {
  default = "Standard"
}
variable "account_replication_type" {
  default = "LRS"
}
variable "pool_allocation_mode" {
  default = "BatchService"
}

variable "vm_size" {
}
variable "node_agent_sku_id" {
  default = "batch.node.windows amd64"
}
variable "sto_img_publisher" {
  default="MicrosoftWindowsServer"
}
variable "sto_img_offer" {
  default="WindowsServer"
}
variable "sto_img_sku" {
  default="2019-Datacenter-with-Containers"
}
variable "sto_img_version" {
  default = "latest"
}
variable "container_configuration_type" {
  default = "DockerCompatible"
}
variable "server" {
}

variable "auto_scale_interval" {

}

variable "auto_scale_formula" {

}

variable "cert_format" {
    default = "Cer"
}
variable "cert_thumbprint" {
    default = "dac9024f54d8f6df94935fb1732638ca6ad77c13"
}
variable "cert_algo" {
    default = "SHA1"
}

variable "cert_store_name" {
    default = "df_cert"
}
variable "cert_location" {
    default = "LocalMachine"
}

variable "df_enable_gitsync" {
  default = false
}
variable "identity_type" {
  default = "SystemAssigned"
}
variable "vsts_account_name" {
  default = "GFIOSvr"
}
variable "vsts_project_name" {
  default = "GRM 2"
}
variable "vsts_repository_name" {
  default = "Grundfos.GiC.WWNC.FlowEstimation.Pipeline"
}
variable "vsts_branch_name" {
  default = "data_factory"
}
variable "vsts_root" {
  default = "/"
}
variable "wwnc_rawdata_conn_string" {
  
}

variable "service_bus_send_policy" {
  
}

variable "sku_name" {
  default = "standard"
}

variable "access_policies" {
  type = list(object({
    object_id          = string
    key_permissions    = list(string)
    secret_permissions = list(string)
  }))

  default = []
}

variable "signedin_clientId" {
  
}
variable "location_short" {
  
}
variable "project" {
  
}

variable "acr_username" {
  
}

variable "acr_password" {
  
}

variable "docker_enable" {
}










