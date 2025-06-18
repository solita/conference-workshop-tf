param apimName string
param sku string
param publisherName string
param publisherEmail string
param tags object
param triggers object

param httpbinConfig object
param ordersApiConfig object

resource apim 'Microsoft.ApiManagement/service@2024-05-01' = {
  name: apimName
  location: resourceGroup().location
  sku: {
    name: sku
    capacity: 1
  }
  properties: {
    publisherName: publisherName
    publisherEmail: publisherEmail
  }
  tags: tags
}

module httpbin './httpbin.bicep' = {
  params: {
    apimName: apim.name
    name: httpbinConfig.name
    serviceUrl: httpbinConfig.serviceUrl
    oas: httpbinConfig.oas
  }
}

module ordersApi './orders/api.bicep' = {
  params: {
    apimName: apim.name
    name: ordersApiConfig.name
    path: ordersApiConfig.path
    triggers: triggers
  }
}
