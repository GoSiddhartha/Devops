## Azure resource provider ##
provider "azurerm" {
  version         = "2.6.0"
  features {}
}

module "az_resource_group" {
  source = "../Modules/rg"

  resource_group_name = "GF-RG-${upper(var.project)}-${upper(var.environment)}-AZWE"
  location            = var.location
  category            = "GiC ${var.environment} environment"
  description         = "GiC-Analytics"
}

module "az_keyvault" {
  source = "../Modules/keyvault"

  name                            = "gf-keyv-${var.project}-${var.environment}-azwe"
  location                        = var.location
  resource_group_name             = module.az_resource_group.name
  sku                             = var.kv_sku_name
  access_policies                 = var.access_policies
  //tenant_id                       = var.tenant_id
}

module "az_storage_account_data" {
  source = "../Modules/storage"

  storage_name             = "gfsto${var.project}img${var.environment}azwe"
  resource_group_name      = module.az_resource_group.name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  is_hns_enabled 		   = true
}

module "az_storage_account_data_container" {
  source = "../Modules/container"
  
  name = "boatswain"
  storage_account_name = module.az_storage_account_data.name
}

module "az_storage_account_app" {
  source = "../Modules/storage"

  storage_name             = "gfsto${var.project}app${var.environment}azwe"
  resource_group_name      = module.az_resource_group.name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  is_hns_enabled 		   = false
}

module "az_batch_account" {
  source = "../Modules/batch-ac"

  batch_account_name   = "gfbatch${var.project}${var.environment}azwe"
  resource_group_name  = module.az_resource_group.name
  location             = var.location
  allocation_mode = var.pool_allocation_mode
  storage_account_id   = module.az_storage_account_app.id

}

module "az_batch_pool" {
  source = "../Modules/batchpool"

  batch_pool_name              = "gfpool${var.project}win${var.environment}azwe"
  resource_group_name          = module.az_resource_group.name
  batch_account_name           = module.az_batch_account.name
  display_name                 = "Windows pool for Data Pipeline Azure"
  vm_size                      = var.vm_size
  node_agent_sku_id            = var.node_agent_sku_id
  sto_img_publisher            = var.sto_img_publisher
  sto_img_offer                = var.sto_img_offer
  sto_img_sku                  = var.sto_img_sku
  sto_img_version              = var.sto_img_version
  container_configuration_type = var.container_configuration_type
  server                       = var.server
  auto_scale_interval          = var.auto_scale_interval
  auto_scale_formula           = var.auto_scale_formula
  cert_format                  = var.cert_format
  cert_thumbprint              = var.cert_thumbprint
  cert_algo                    = var.cert_algo
  cert_store_name              = var.cert_store_name
  cert_location                = var.cert_location
  acr_username                 = var.acr_username
  acr_password                 = var.acr_password
  environment                  = var.environment
  docker_enable                = var.docker_enable
}

module "az_data_factory" {
  source = "../Modules/datafactory"

  df_enable_gitsync    = var.df_enable_gitsync
  df_name              = "gfdf${var.project}${var.environment}azwe"
  resource_group_name  = module.az_resource_group.name
  location             = var.location
  identity_type        = var.identity_type
  vsts_account_name    = var.vsts_account_name
  vsts_project_name    = var.vsts_project_name
  vsts_repository_name = var.vsts_repository_name
  vsts_branch_name     = var.vsts_branch_name
  vsts_root            = var.vsts_root
  tenant_id            = var.tenant_id
  kv_id                = module.az_keyvault.id

}

data "azurerm_servicebus_topic_authorization_rule" "sb_conn_string" {
  name                = "Grundfos.Gic.WWNC.FlowEstimation"
  resource_group_name = "GF-RG-SHARED-MESSAGING-${var.environment}-AZWE"
  namespace_name      = "gf-sb-gicshared-${var.environment}-azwe"
  topic_name          = "grundfos.gic.guatodeviceidmapper.fileuploaded"
}

module "az_keyvault_secrets" {
  source = "../Modules/kv-secrets"

  kv_id      = module.az_keyvault.id
  kv_keys    = ["WwncRawDataStorageConnectionString", "ServiceBusConnectionString","ServiceBusSendPolicy","BoatswainDataStorageKey","BoatswainDataStorageConnectionString","BoatswainAppStorageKey","BoatswainAppStorageConnectionString","BoatswainBatchKey","BoatswainBatchEndpoint","BoatswainBatchName","BoatswainBatchWinPoolName"]
  kv_secrets = [var.wwnc_rawdata_conn_string, data.azurerm_servicebus_topic_authorization_rule.sb_conn_string.primary_connection_string, var.service_bus_send_policy, module.az_storage_account_data.storagekey, module.az_storage_account_data.connection, module.az_storage_account_app.storagekey, module.az_storage_account_app.connection, module.az_batch_account.accesskey, format("https://%s", module.az_batch_account.endpoint), module.az_batch_account.name, module.az_batch_pool.name]

}





