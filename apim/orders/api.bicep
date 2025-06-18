param name string
param apimName string
param path string
param triggers object

resource versionSet 'Microsoft.ApiManagement/service/apiVersionSets@2024-05-01' = {
  name: '${apimName}/${name}-version-set'
  properties: {
    displayName: name
    versioningScheme: 'Segment'
  }
}

module api_v1_0_0 './module.bicep' = {
  params: {
    name: name
    apimName: apimName
    version: '1.0.0'
    oas: loadTextContent('../../oas/orders/1_0_0.yaml')
    path: path
    versionSetId: versionSet.id
  }
}

// Create a named value for every operation.
resource api_v1_0_0_get_orders_base_path 'Microsoft.ApiManagement/service/namedValues@2024-05-01' = {
name: '${apimName}/api_orders_api_v1_0_0_get_orders_base_path'
  properties: {
    displayName: 'api_orders_api_v1_0_0_get_orders_base_path'
    value: triggers.la_get_orders_trigger.basePath
  }
}

// Create a named value for every operation.
resource api_v1_0_0_get_orders_signature 'Microsoft.ApiManagement/service/namedValues@2024-05-01' = {
  name: '${apimName}/api_orders_api_v1_0_0_get_orders_signature'
  properties: {
    displayName: 'api_orders_api_v1_0_0_get_orders_signature'
    value: triggers.la_get_orders_trigger.queries.sig
    secret: true // Mark as secret to hide in portal
  }
}

resource operation_policy_1_0_0_get_orders 'Microsoft.ApiManagement/service/apis/operations/policies@2024-05-01' = {
  name: '${apimName}/${name}-v1-0-0/get_orders/policy'
  properties: {
    format: 'xml'
    value: '''
    <policies>
      <inbound>
        <base />
        <rewrite-uri template="?api-version=2019-05-01&amp;sp=/triggers/manual/run&amp;sv=1.0&amp;sig={{api_orders_api_v1_0_0_get_orders_signature}}" />
        <set-backend-service base-url="{{api_orders_api_v1_0_0_get_orders_base_path}}" />
      </inbound>
    </policies>
    '''
  }
  dependsOn: [api_v1_0_0_get_orders_base_path, api_v1_0_0_get_orders_signature]
}

module api_v1_1_0 './module.bicep' = {
  params: {
    name: name
    apimName: apimName
    version: '1.1.0'
    oas: loadTextContent('../../oas/orders/1_1_0.yaml')
    path: path
    versionSetId: versionSet.id
  }
}
