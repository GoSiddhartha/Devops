output "name" {
  value = "${ var.docker_enable ? azurerm_batch_pool.bp_docker[0].name : azurerm_batch_pool.bp[0].name}"
}

