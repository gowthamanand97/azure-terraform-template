variable "resource_group" {
    type        = string
    default = "terraform-rg"
}

variable "location" {
    type        = string
    default = "West US 2"
}

variable "ddos_protection_plan" {
  type        = string
  default     = "ddospplan1"
}

variable "vnet_name" {
  description = "Name of the vnet to create"
  type        = string
  default     = "mg-tf-vnet"
}

variable "akssub" {
  description = "Name of the vnet to create"
  type        = string
  default     = "mg-tf-akssub"
}

variable "address_spaces" {
  type        = list(string)
  default     = ["10.0.0.0/21"]
}


variable "subnet_address_prefix" {
  description = "aks CIDR"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "dmz_name" {
  description = "subnet2"
  type        = string
  default     = "mg-tf-dmz"
}

variable "dmz_subnet_address_prefix" {
  description = "DMZ"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "trust_name" {
  description = "subnet2"
  type        = string
  default     = "mg-tf-trust"
}

variable "trust_subnet_address_prefix" {
  description = "DMZ"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "nsg" {
  type        = string
  default     = "mg-tf-mongonsg"
}