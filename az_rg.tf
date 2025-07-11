# Resource Group
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group

resource "azurerm_resource_group" "rg" {
  name     = local.rg.name
  location = local.region

  # Solita policy:
  tags = local.tags
}
