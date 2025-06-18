param name string
param apimName string
param serviceUrl string
param oas string

resource api 'Microsoft.ApiManagement/service/apis@2024-05-01' = {
  name: '${apimName}/${name}'
  properties: {
    path: 'httpbin'
    protocols: [
      'https'
    ]
    serviceUrl: serviceUrl
    format: 'openapi-link'
    value: oas
    subscriptionRequired: false
  }
}
