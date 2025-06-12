output "apim_gateway_url" {
  description = "The public URL of the API Management gateway."
  value = azurerm_api_management.apim.gateway_url
}
