targetScope = 'subscription'

param location string
param tags object
param resourceGroupName string
param apimConfig object

param httpbinConfig object
param ordersApiConfig object

module rg './rg.bicep' = {
  params: {
    location: location
    resourceGroupName: resourceGroupName
    tags: tags
  }
}

module apim './apim/apim.bicep' = {
  scope: resourceGroup(resourceGroupName)
  params: {
    apimName: apimConfig.name
    publisherName: apimConfig.publisherName
    publisherEmail: apimConfig.publisherEmail
    sku: apimConfig.sku
    tags: tags
    httpbinConfig: httpbinConfig
    ordersApiConfig: ordersApiConfig
    triggers: la.outputs
  }
}

module la './la/orders/main.bicep' = {
  scope: resourceGroup(resourceGroupName)
}
