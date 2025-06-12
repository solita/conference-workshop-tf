output "secret_value" {
  value     = data.azurerm_key_vault_secret.example.value
  sensitive = true
}

output "secret_value_plaintext" {
  value       = nonsensitive(data.azurerm_key_vault_secret.example.value)
  description = "Secret value in plaintext - use with caution!"
}
