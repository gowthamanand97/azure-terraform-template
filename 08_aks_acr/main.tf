resource "azurerm_resource_group" "rg" {
  name     = "aks_terraform_rg"
  location = "West-US"
}

resource "azurerm_role_assignment" "role_acrpull" {
  scope                            = azurerm_container_registry.acr.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.aks.kubelet_identity.0.object_id
  skip_service_principal_aad_check = "true"
}

resource "azurerm_container_registry" "acr" {
  name                = "container"
  resource_group_name = azurerm_resource_group.rg.name
  location            = "West-US"
  sku                 = "Standard"
  admin_enabled       = "false"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "terraform-aks"
  kubernetes_version  = "1.19.3"
  location            = West-US
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "terraform-aks"

  default_node_pool {
    name                = "system"
    node_count          = 3
    vm_size             = "Standard_DS2_v2"
    type                = "VirtualMachineScaleSets"
    availability_zones  = [1, 2, 3]
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet" # CNI
  }
}