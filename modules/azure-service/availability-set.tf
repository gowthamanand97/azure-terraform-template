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
 
resource "azurerm_availability_set" "example" {
  name                = "aathithanambi"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
 
  tags = {
    environment = "Production"
  }
}