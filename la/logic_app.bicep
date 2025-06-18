param name string
param definition object

resource logicApp 'Microsoft.Logic/workflows@2019-05-01' = {
  name: name
  location: resourceGroup().location
  properties: {
    definition: definition
  }
}

@secure()
output trigger object = listCallbackUrl('${logicApp.id}/triggers/manual', '2019-05-01')
