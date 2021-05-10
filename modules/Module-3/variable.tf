variable "resource_group" {
    type        = string
    default = "terraform-rg"
}

variable "application_service" {
  type        = string
  default     = "api-appserviceplan-pro"
}


variable "application_insights" {
  type        = string
  default     = "tf-test-appinsights"
}

variable "application_type" {
  type        = string
  default     = "web"
}

variable "web_test" {
  type        = string
  default     = "tf-test-appinsights-webtest"
}


variable "enabled" {
  type        = bool
  default = "true"
}

variable "keyvault_name" {
  type        = string
  description = "Key Vault name in Azure"
  default     = "demokeyvaultmedi1"
}

variable "secret_name" {
  type        = string
  description = "Key Vault Secret name in Azure"
  default     = "DatabasePassword"

}

variable "secret_value" {
  type        = string
  description = "Key Vault Secret value in Azure"
  default   = "@Aa123456789!"
}

variable "sku_name" {
  type        = string
  default     = "standard"
}

variable "role_definition_name" {
  type        = string
  default     = "Key Vault Secrets User"
}

variable "enable_rbac_authorization" {
  type        = bool
  default = "true"
}

variable "log_analytics" {
  type        = string
  default     = "acctest"
}

variable "sku" {
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  type        = number
  default     = 60
}

variable "storage_account" {
  type        = string
  default	  = "storageaccount123gow"
}

variable "account_tier" {
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  default     = "ZRS"
}

variable "access_tier" {
  type        = string
  default     = "Hot"
}

variable "allow_blob_public_access" {
  type        = bool
  default     = true
}
variable "storage_container_name" {
  type        = string
  description = "Storage Container name in Azure"
  default 	  = "container"
}

variable "blob" {
  type        = string
  description = "Storage Container name in Azure"
  default 	  = "blob"
}

variable "container_access_type" {
  type        = string
  description = "Storage Container name in Azure"
  default 	  = "container"
}

variable "type" {
  type        = string
  description = "Storage Container name in Azure"
  default 	  = "Block"
}

