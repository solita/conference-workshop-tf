# API Management
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management

resource "azurerm_api_management" "apim" {
  name                = local.apim.name

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  publisher_name      = local.apim.publisher_name
  publisher_email     = local.apim.publisher_email

  sku_name = var.apim_sku_name
  min_api_version = var.apim_min_api_version

  # Solita policy:
  tags = local.tags
}

resource "azurerm_api_management_api_version_set" "github_version_set" {
  name                = "github-version-set"

  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name

  display_name        = "Github Version Set"
  versioning_scheme   = "Header"

  version_header_name = "X-GitHub-Api-Version"
}

resource "azurerm_api_management_api" "github_v1" {
  name = "github"

  resource_group_name = azurerm_resource_group.rg.name
  api_management_name = azurerm_api_management.apim.name

  version_set_id = azurerm_api_management_api_version_set.github_version_set.id

  version = "2022-11-28"
  revision = "1"

  display_name = "GitHub v3 REST API"
  description = "GitHub's v3 REST API."
  path = "github"
  protocols = ["https"]

  subscription_required = false

  import {
    content_format = "openapi+json-link"
    content_value = "https://raw.githubusercontent.com/github/rest-api-description/main/descriptions/api.github.com/api.github.com.json"
  }

  terms_of_service_url = "https://docs.github.com/articles/github-terms-of-service"

  license {
    name = "MIT"
    url = "https://spdx.org/licenses/MIT"
  }

  contact {
    name = "Support"
    url = "https://support.github.com/contact?tags=dotcom-rest-api"
  }

  lifecycle {
    ignore_changes = [
      import
    ]
  }
}
