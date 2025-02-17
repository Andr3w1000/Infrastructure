resource "azurerm_resource_group" "resourcegroups" {
    name        = var.ResourceGroup
    location    = var.Location
}

data "azurerm_service_principal" "devOps" {
  display_name = "GitHubDevOps"  # Replace with your Service Principal's Display Name
}

resource "azurerm_role_assignment" "example" {
  principal_id   = devOps.id
  role_definition_name = "Contributor"
  scope           = azurerm_resource_group.example.id
}

resource "azurerm_storage_account" "storageaccounts" {
    name                     = "dtlstorageaccountbronze"
    resource_group_name      = azurerm_resource_group.resourcegroups.name
    location                 = azurerm_resource_group.resourcegroups.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
}