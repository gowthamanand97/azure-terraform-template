resource "azurerm_resource_group" "rg" {
  name     = "public-ip"
  location = "West-US"
}
resource "azurerm_public_ip" "public_ip" {
  name                = "public"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  allocation_method   = "Static"
  sku                 = "Basic"
  ip_version          = "IPv4"
  Routing_preference  = "Internet"
  domain_name_label   = xxxx.westus.cloudapp.azure.com
  Availability_zone   = "Zone-redundant"
  tags = public-ip
}