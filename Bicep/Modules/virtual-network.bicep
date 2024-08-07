param location string
param tags object = {}
param vnet object
param deployNSG bool = false

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

resource networkSecurityGroupResource 'Microsoft.Network/networkSecurityGroups@2023-09-01' = if (deployNSG) { 
  name: '${vnet.name}-nsg-01'
  location: location
  properties: {
    securityRules: [
      {
        name: 'SSH'
        properties: {
          priority: 1000
          protocol: 'Tcp'
          access: 'Allow'
          direction: 'Inbound'
          sourceAddressPrefix: '*'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
          destinationPortRange: '22'
        }
      }
    ]
  }
}

output networkSecurityGroupId string = networkSecurityGroupResource.id
output subnetId string = virtualNetworkResource.properties.subnets[0].id
