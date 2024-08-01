param location string
param tags object = {}
param vnet object

resource virtualNetworkResource 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnet.name
  tags: tags
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet.addressPrefix
      ]
    }
    subnets: [
      {
        name: vnet.subnetName
        properties: {
          addressPrefix: vnet.subnetAddressPrefix
        }
      }
    ]
  }
}

output subnetId string = virtualNetworkResource.properties.subnets[0].id
