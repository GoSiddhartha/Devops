terraform {
  source = "../..//main"
}

remote_state {
    backend  = "azurerm"

    generate = {
      path      = "backend.tf"
      if_exists = "overwrite_terragrunt"
    }
    
    config = {
        key                   = "fedatafactory/terraform.tfstate"
        resource_group_name   = "GF-RG-CLOUDNATIVE-STATE-P-AZWE"
        storage_account_name  = "gfstowwtfstatepazwe"
        container_name        = "tfstate"
    }
}

inputs = {
    location            = "westeurope"
    location_short      = "azwe"
    environment         = "p"
    vm_size             = "Standard_F4s_v2"
    server              = "gfacrwwncx1azwe.azurecr.io"
    auto_scale_interval = "PT5M"
    docker_enable       = false
	  df_enable_gitsync 	= false
    auto_scale_formula  = <<EOF
      startingNumberOfVMs = 2;
      maxNumberofVMs = 25;
      pendingTaskSamplePercent = $PendingTasks.GetSamplePercent(180 * TimeInterval_Second);
      pendingTaskSamples = pendingTaskSamplePercent < 70 ? startingNumberOfVMs : avg($PendingTasks.GetSample(180 *   TimeInterval_Second));
      $TargetDedicatedNodes=min(maxNumberofVMs, pendingTaskSamples);
    EOF
    tags = {
        Name = "flow-estimation"
        Env  = "P"
    }
    project = "bswain"
    access_policies = [
    {
      object_id          = "6a9a4e85-c634-4a4a-9eff-99290906da58"
      key_permissions     = ["get", "list", "purge", "delete"]
      secret_permissions = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
    },
    {
      object_id          = "875075cd-b0b4-48f9-8e9d-5b4c35d65006"
      key_permissions     = ["get", "list", "purge", "delete"]
      secret_permissions = ["backup", "delete", "get", "list", "purge", "recover", "restore", "set"]
    },
    {
      object_id          = "c0f55f42-05f3-4976-aa06-a1df91162880" #prdone cluster
      key_permissions    = ["create", "get", "list"]
      secret_permissions = ["set", "get", "list", "delete"]
    },
    {
      object_id          = "f5da29ef-f4a3-47be-8e42-4d0b339afdb3" #opsone cluster
      key_permissions    = ["create", "get", "list"]
      secret_permissions = ["set", "get", "list", "delete"]
    }
  ]
}
