targetScope = 'subscription'

param location string
param resourceGroupName string
param tags object

resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}
