
resource "azurerm_resource_group" "devops_rg" {
  name     = "devops_rgg" #create
  location = "Central US"


}

# create 4 resource group 
resource "azurerm_storage_account" "acc_creator" {
  for_each                 = var.storage_acc_name
  name                     = each.key
  resource_group_name      = azurerm_resource_group.devops_rg.name
  location                 = azurerm_resource_group.devops_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}