#create azure ad group
resource "azuread_group" "DevOps" {
    display_name = "DevOps"
    security_enabled = true
}
resource "azurerm_resource_group" "devops_rg" {
    name = "devops_rg"
    location = "Central US"

  
}
#give group RBAC read to resource group
resource "azurerm_role_assignment" "devops_redear" {
    scope = azurerm_resource_group.devops_rg.id
    role_definition_name = "Reader"
    principal_id = azuread_group.DevOps.object_id
  
}
#Create user
resource "azuread_user" "dev_ops_user1" {
    user_principal_name = "a5aled94@yahoo.com"
    display_name = "hemdan"
    password = "hemdan"
  
}
#add user to group
resource "azuread_group_member" "add_dev_ops_users" {
    group_object_id = azuread_group.DevOps.object_id
    member_object_id = azuread_user.dev_ops_user1.object_id 
}
#create app reg
resource "azuread_application" "myapp" {
  display_name = "my-application"
}
#create service principle
resource "azuread_service_principal" "myapp" {
  client_id = azuread_application.myapp.client_id
}
#service principle with azure permission
resource "azurerm_role_assignment" "reader" {
  scope                = azurerm_resource_group.devops_rg.id
  role_definition_name = "Reader"
  principal_id         = azuread_service_principal.myapp.object_id
}