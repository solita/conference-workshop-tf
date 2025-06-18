param name string
param apimName string
param path string
param oas string
param version string
param versionSetId string

var sanitizedVersion = replace(version, '.', '-')

resource api 'Microsoft.ApiManagement/service/apis@2024-05-01' = {
  name: '${apimName}/${name}-v${sanitizedVersion}'
  properties: {
    path: path
    protocols: [
      'https'
    ]
    apiVersionSetId: versionSetId
    apiVersion: version
    format: 'openapi'
    value: oas
    subscriptionRequired: false
  }
}

output apiName string = api.name
