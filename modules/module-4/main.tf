# Get Resources from a Resource Group
data "azurerm_resource_group" "example" {
  name = var.resource_group_name
}

# Get Resources from a Subnet
data "azurerm_subnet" "example" {
  name                 = var.azurerm_subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
}

# ACR
resource "azurerm_container_registry" "acr" {
  name                = var.azurerm_container_registry
  resource_group_name = data.azurerm_resource_group.example.name
  location            = var.azurerm_container_registry_location 
  sku                 = var.azurerm_container_registry_sku
  admin_enabled       = var.azurerm_container_registry_admin_enabled 
}

# AKS
resource "azurerm_kubernetes_cluster" "example" {
  name                = var.azurerm_kubernetes_cluster_name
  location             = data.azurerm_resource_group.example.location
  resource_group_name  = data.azurerm_resource_group.example.name
  dns_prefix          = var.azurerm_kubernetes_cluster_dns_prefix

  default_node_pool {
    name                = var.node_pool_name
    node_count          = var.node_pool_count
    vm_size             = var.node_pool_vm_size
    type                = var.node_pool_vm_type
    availability_zones  = var.node_pool_vm_availability_zones
    enable_auto_scaling = var.node_pool_enable_auto_scaling
    min_count           = var.auto_scaling_min_count
    max_count           = var.auto_scaling_max_count

    # Required for advanced networking
    vnet_subnet_id = data.azurerm_subnet.example.id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = var.network_plugin
    load_balancer_sku = var.network_load_balancer_sku
    network_policy    = var.network_policy
    service_cidr      = var.vnet_service_cidr
    docker_bridge_cidr= var.network_docker_bridge_cidr
    dns_service_ip    = var.vnet_dns_servers
  }

  tags = {
    Environment = "Development"
  }
}

