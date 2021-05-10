output "client_certificate" {
  value = azurerm_kubernetes_cluster.demo.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.demo.kube_config_raw
}

output "resource_group_name" {
  value = data.azurerm_resource_group.demo.name
}

output "resource_group_location" {
  value = data.azurerm_resource_group.demo.location
}

output "subnet_id" {
  value = data.azurerm_subnet.demo.id
}
