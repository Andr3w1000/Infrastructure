provider "azurerm" {
  features {}
}

module "common" {
  source = "../shared"
}

locals {
  merged_tags = merge(
    module.common.global_default_tags,
    var.default_tags
  )
}


data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "rg" {
  name     = "ETL-project"
  location = "West Europe"
}

resource "azurerm_storage_account" "storageAcc" {
  name                     = "bandidatalake"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
  tags                     = local.merged_tags
}

# HACK: Role assignment is needed to apply adls gen2 filesystem changes
resource "azurerm_role_assignment" "data_role" {
  scope                = azurerm_storage_account.storageAcc.id
  role_definition_name = "Storage Blob Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}
resource "azurerm_role_assignment" "contributor_role" {
  scope                = azurerm_storage_account.storageAcc.id
  role_definition_name = "Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_storage_data_lake_gen2_filesystem" "bronze" {
  name               = "bronze"
  storage_account_id = azurerm_storage_account.storageAcc.id

  properties = {
    hello = "aGVsbG8="
  }
  depends_on = [azurerm_role_assignment.contributor_role]
}

resource "azurerm_storage_data_lake_gen2_filesystem" "silver" {
  name               = "silver"
  storage_account_id = azurerm_storage_account.storageAcc.id

  properties = {
    hello = "aGVsbG8="
  }
  depends_on = [azurerm_role_assignment.contributor_role]
}

resource "azurerm_storage_data_lake_gen2_filesystem" "gold" {
  name               = "gold"
  storage_account_id = azurerm_storage_account.storageAcc.id

  properties = {
    hello = "aGVsbG8="
  }
  depends_on = [azurerm_role_assignment.contributor_role]
}
