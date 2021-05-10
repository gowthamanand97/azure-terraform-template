# valid for terraform version 0.14
provider "azurerm" {
  features {}
}
 
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.40.0"
    }
  }
}
 
resource "azurerm_resource_group" "example" {
  name     = "example-resource-medi"
  location = "West US 2"
}
 
resource "azurerm_key_vault" "example" {
  name                = "aathithanambi"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "premium"
}
 
resource "azurerm_key_vault_access_policy" "example" {
  key_vault_id = azurerm_key_vault.example.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id
 
  key_permissions = [
    "Get",
  ]
 
  secret_permissions = [
    "Get",
  ]
}