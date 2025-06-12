# Key Vault
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault

resource "azurerm_key_vault" "kv" {
  name = local.kv.name

  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  tenant_id = data.azurerm_client_config.current.tenant_id

  sku_name = var.kv_sku_name

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
    ]
  }

  tags = local.tags
}

# Random string for unique naming
resource "random_string" "secret" {
  length = 12
  special = true
  upper   = true
}

# Key Vault Secret
resource "azurerm_key_vault_secret" "example" {
  name = "example-secret"
  value = random_string.secret.result

  key_vault_id = azurerm_key_vault.kv.id
}

# Data source to retrieve the secret
data "azurerm_key_vault_secret" "example" {
  name         = azurerm_key_vault_secret.example.name

  key_vault_id = azurerm_key_vault.kv.id
  
  depends_on = [azurerm_key_vault_secret.example]
}
