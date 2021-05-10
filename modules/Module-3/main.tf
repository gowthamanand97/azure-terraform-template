data "azurerm_resource_group" "example" {
  name     = var.resource_group
}

resource "azurerm_app_service_plan" "example" {
  name                = var.application_service
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name

  sku {
    tier = var.sku_name
    size = "S1"
  }
}
resource "azurerm_application_insights" "example" {
  name                = var.application_insights
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
  application_type    = var.application_type
}

resource "azurerm_application_insights_web_test" "example" {
  name                    = var.web_test
  location                = data.azurerm_resource_group.example.location
  resource_group_name     = data.azurerm_resource_group.example.name
  application_insights_id = azurerm_application_insights.example.id
  kind                    = "ping"
  frequency               = 300
  timeout                 = 60
  enabled                 = var.enabled
  geo_locations           = ["us-tx-sn1-azr", "us-il-ch1-azr"]

  configuration = <<XML
<WebTest Name="WebTest1" Id="ABD48585-0831-40CB-9069-682EA6BB3583" Enabled="True" CssProjectStructure="" CssIteration="" Timeout="0" WorkItemIds="" xmlns="http://microsoft.com/schemas/VisualStudio/TeamTest/2010" Description="" CredentialUserName="" CredentialPassword="" PreAuthenticate="True" Proxy="default" StopOnError="False" RecordedResultFile="" ResultsLocale="">
  <Items>
    <Request Method="GET" Guid="a5f10126-e4cd-570d-961c-cea43999a200" Version="1.1" Url="http://microsoft.com" ThinkTime="0" Timeout="300" ParseDependentRequests="True" FollowRedirects="True" RecordResult="True" Cache="False" ResponseTimeGoal="0" Encoding="utf-8" ExpectedHttpStatusCode="200" ExpectedResponseUrl="" ReportingName="" IgnoreHttpStatusCode="False" />
  </Items>
</WebTest>
XML

}

resource "azurerm_key_vault" "keyvault" {
  name                        = var.keyvault_name
  location                    = data.azurerm_resource_group.example.location
  resource_group_name         = data.azurerm_resource_group.example.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  sku_name                    = var.sku_name

  enable_rbac_authorization   = true
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "role-secret-officer" {
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
  scope                = azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "database-password" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = azurerm_key_vault.keyvault.id

  depends_on   = [azurerm_role_assignment.role-secret-officer]
}

resource "azurerm_role_assignment" "role-secret-user" {
  role_definition_name = var.role_definition_name
  principal_id         = data.azurerm_client_config.current.object_id
  scope                = "${azurerm_key_vault.keyvault.id}/secrets/${azurerm_key_vault_secret.database-password.name}"
  // scope                = "/subscriptions/xxxxxxxxx/resourceGroups/kv_rbac_terraform_rg/providers
  //                         /Microsoft.KeyVault/vaults/demokv01093/secrets/MySecret"
  // scope                = azurerm_key_vault_secret.database-password.id
}

resource "azurerm_log_analytics_workspace" "example" {
  name                = var.log_analytics
  location            = data.azurerm_resource_group.example.location
  resource_group_name = data.azurerm_resource_group.example.name
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
}

resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account
  resource_group_name      = data.azurerm_resource_group.example.name
  location                 = data.azurerm_resource_group.example.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  allow_blob_public_access = var.allow_blob_public_access
}

resource "azurerm_storage_container" "container" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.storage.name
  container_access_type = var.container_access_type # "blob" "private"
}

resource "azurerm_storage_blob" "blob" {
  name                   = var.blob
  storage_account_name   = azurerm_storage_account.storage.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = var.type
  
}