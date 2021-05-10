provider "azurerm" {
  features {}
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.57.0"
    }
  }
}
resource "azurerm_resource_group" "example" {
  name     = var.resource_group
  location = var.location
}

resource "azurerm_network_ddos_protection_plan" "example" {
  name                = var.ddos_protection_plan
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  address_space       = var.address_spaces
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.example.id
    enable = true
  }
}
resource "azurerm_subnet" "akssubnet" {
  name                 = var.akssub
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = var.subnet_address_prefix
}

resource "azurerm_subnet" "dmz" {
  name                 = var.dmz_name
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = var.dmz_subnet_address_prefix
}
resource "azurerm_subnet" "trust" {
  name                 = var.trust_name
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = var.trust_subnet_address_prefix
}

resource "azurerm_network_security_group" "example" {
  name                = var.nsg
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.trust.id
  network_security_group_id = azurerm_network_security_group.example.id
}


 
module "linuxvm" {
  source              = "./Module-2"
  depends_on = [azurerm_virtual_network.example, azurerm_subnet.trust]
}

module "app_services" {
  source              = "./Module-3"
  depends_on = [azurerm_resource_group.example]
}

module "aks" {
  source              = "./Module-4"
  depends_on = [azurerm_resource_group.example, azurerm_virtual_network.example, azurerm_subnet.akssubnet]
}
