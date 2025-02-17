resource "azurerm_resource_group" "resourcegroups" {
    name        = var.ResourceGroup
    location    = var.Location
}

resource "azurerm_storage_account" "storageaccounts" {
    name                     = "dtlstorageaccountbronze"
    resource_group_name      = azurerm_resource_group.resourcegroups.name
    location                 = azurerm_resource_group.resourcegroups.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
}