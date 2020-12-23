resource "azurerm_batch_certificate" "cer" {
  resource_group_name  = var.resource_group_name
  account_name         = var.batch_account_name
  certificate          = filebase64("../Modules/batchpool/batch.cer")
  format               = var.cert_format
  thumbprint           = var.cert_thumbprint
  thumbprint_algorithm = var.cert_algo
}

resource "azurerm_batch_pool" "bp_docker" {
  count               = var.docker_enable ? 1 : 0

  name                = var.batch_pool_name
  resource_group_name = var.resource_group_name
  account_name        = var.batch_account_name

  display_name      = var.display_name
  vm_size           = var.vm_size
  node_agent_sku_id = var.node_agent_sku_id

  storage_image_reference {
    publisher = var.sto_img_publisher
    offer     = var.sto_img_offer
    sku       = var.sto_img_sku
    version   = var.sto_img_version
  }

  container_configuration {
    type = var.container_configuration_type
    container_registries {
      registry_server = var.server
      user_name       = var.acr_username
      password        = var.acr_password
    }
  }

  auto_scale {
    evaluation_interval = var.auto_scale_interval

    formula = var.auto_scale_formula

  }

  start_task {
    command_line         = "cmd /c dir /s"
    max_task_retry_count = 1
    wait_for_success     = true

    environment = {
      env = var.environment
    }

    user_identity {
      auto_user {
        elevation_level = "NonAdmin"
        scope           = "Task"
      }
    }
  }

}

resource "azurerm_batch_pool" "bp" {
  count               = var.docker_enable ? 0 : 1

  name                = var.batch_pool_name
  resource_group_name = var.resource_group_name
  account_name        = var.batch_account_name

  display_name      = var.display_name
  vm_size           = var.vm_size
  node_agent_sku_id = var.node_agent_sku_id

  storage_image_reference {
    publisher = var.sto_img_publisher
    offer     = var.sto_img_offer
    sku       = var.sto_img_sku
    version   = var.sto_img_version
  }

  auto_scale {
    evaluation_interval = var.auto_scale_interval

    formula = var.auto_scale_formula

  }

}