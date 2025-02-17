resource "azurerm_resource_group" "resourcegroups" {
    name        = var.ResourceGroup
    location    = var.Location
}

# data "azurerm_service_principal" "devOps" {
#   display_name = "GitHubDevOps"  # Replace with your Service Principal's Display Name
# }

resource "azurerm_role_assignment" "roleassignments" {
    principal_id   = "823aa1dc-d6f9-421a-bf26-70240d155855"
    role_definition_name = "Contributor"
    scope = azurerm_resource_group.resourcegroups.id
}

resource "azurerm_storage_account" "storageaccounts" {
    name                     = "dtlstorageaccountbronze"
    resource_group_name      = azurerm_resource_group.resourcegroups.name
    location                 = azurerm_resource_group.resourcegroups.location
    account_tier             = "Standard"
    account_replication_type = "LRS"
}