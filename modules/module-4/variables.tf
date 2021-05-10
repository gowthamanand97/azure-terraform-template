variable "resource_group_name" {
  description = "Enter the name of the Resource group Resources"
  default = "terraform-rg"
}

variable "azurerm_subnet_name" {
  default     = "mg-tf-akssub"
  description = "Enter the name of the Subnet resources"
}

variable "virtual_network_name" {
  default     = "mg-tf-vnet"
  description = "Enter the name of the Vnet resource"
}

# ACR
variable "azurerm_container_registry" {
  default     = "mediguruacr"
  description = "Enter the name of the azurerm container registry"
}

variable "azurerm_container_registry_location" {
  default     = "West US 2"
  description = "Enter the azurerm container registry location"
}


variable "azurerm_container_registry_sku" {
  default     = "Standard"
  description = "Enter the azurerm container registry sku"
}

variable "azurerm_container_registry_admin_enabled" {
  type        = bool
  default     = "false"
  description = "Enable the azure container registry admin"
}

# AKS
variable "azurerm_kubernetes_cluster_name" {
  default     = "sample-deployment-aks"
  description = "Enter the azurerm kubernetes cluster name"
}


variable "azurerm_kubernetes_cluster_dns_prefix" {
  default     = "sample-deployment-aks"
  description = "Enter the azurerm kubernetes cluster dns prefix"
}

# AKS default node pool 
variable "node_pool_name" {
  default     = "default"
  description = "Enter the node pool name"
}

variable "node_pool_count" {
  type        = number
  default     = "1"
  description = "Enter the number of pool virtual machines to create. Default: 3"
}


variable "node_pool_vm_size" {
  default     = "Standard_D2_v2"
  description = "Enter the node pool VM Size "
}

variable "node_pool_vm_type" {
  default     = "VirtualMachineScaleSets"
  description = "Enter the node pool VM Type"
}

variable "node_pool_vm_availability_zones" {
  type        = list(string)
  default     = ["1","2"]
  description = "Enter the node pool VM availability zones"
}

variable "node_pool_enable_auto_scaling" {
  type        = bool
  default     = "true"
  description = "Enter the node pool enable auto scaling"
}

variable "auto_scaling_min_count" {
  type        = number
  description = "The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100"
  default     = 1
}

variable "auto_scaling_max_count" {
  type        = number
  description = "The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 100."
  default     = 2
}

# Network_profile
variable network_plugin {
  type        = string
  description = "Network plugin to use for networking. Currently supported values are azure and kubenet."
  default     = "azure"
}

variable network_load_balancer_sku {
  type        = string
  description = "Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard."
  default     = "standard"
}

variable network_policy {
  type        = string
  description = "Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. This field can only be set when network_plugin is set to azure. Currently supported values are calico and azure."
  default     = "calico"
}

variable vnet_service_cidr {
  type        = string
  description = "The service cidr"
  default     = "10.0.8.0/22"
}

variable network_docker_bridge_cidr {
  type        = string
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes. This is required when network_plugin is set to azure. Defaults to 172.17.0.1/16"
  default     = "10.0.12.1/22"
}

variable vnet_dns_servers {
  type        = string
  description = "List of DNS Servers configured in the VNET"
  default     = "10.0.8.10"
}

