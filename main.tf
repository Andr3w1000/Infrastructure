resource "azurerm_resource_group" "rg" {
  name     = var.ResourceGroup
  location = var.Location
}

resource "azurerm_storage_account" "storageAcc" {
  name                     = "bandidatalake${var.Environment}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}
