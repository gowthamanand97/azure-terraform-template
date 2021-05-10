variable "resource_group" {
    type        = string
    default = "terraform-rg"
}

variable "v_net" {
    type        = string
    default = "mg-tf-vnet"
}

variable "sub_net" {
    type        = string
    default = "mg-tf-trust"
}


variable "publicip" {
  description = "Name of the ip to create"
  type        = string
  default     = "publicip"
}

variable "public_ip_address_allocation" {
  type        = string
  default     = "Dynamic"
}

variable "storage_account_name" {
  description = "Name of the vnet to create"
  type        = string
  default     = "storagemedigurutera"
}

variable "account_tier" {
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  default     = "LRS"
}

variable "linux_virtual_machine" {
  type        = string
  default     = "linux_virtual"
}

variable "vm_size" {
  description = "Defines the Tier to use for this vm."
  type        = string
  default     = "Standard_DS1_v2"
}

variable "os_disk" {
  type        = map(string)
  default = {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }
}

variable "storage_image_reference" {
  description = "storage_image_reference to specify VM image"
  type        = map(string)
  default = {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}


variable "disk_name" {
  description = "Defines the Tier to use for this vm."
  type        = string
  default     = "acctestmd"
}

variable "storage_account_type" {
  description = "Defines the Tier to use for this vm."
  type        = string
  default     = "Standard_LRS"
}

variable "disk_size_gb" {
  description = "Defines the Tier to use for this vm."
  type        = number
  default     = "1"
}
