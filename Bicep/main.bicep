param location string = resourceGroup().location
param tagsParam object = {}
param vnetParam object
param keyVaultParam object
param vmParam object

var serviceName = 'selfhostedagent'

module virtualNetwork 'Modules/virtual-network.bicep' = {
  name: '${serviceName}-virtualNetwork'
  params: {
    vnet: vnetParam
    tags: tagsParam
    location: location
  }
}

module keyVault 'Modules/key-vault.bicep' = {
  name: '${serviceName}-keyVault'
  params: {
    keyVault: keyVaultParam
    tags: tagsParam
    location: location
  }
}

module virtualMachine 'Modules/virtual-machine.bicep' = {
  name: '${serviceName}-virtualMachine'
  params: {
    tags: tagsParam
    location: location
    vm: vmParam
    subnetId: virtualNetwork.outputs.subnetId
  }
  dependsOn: [
    virtualNetwork
  ]
}

output keyVaultId string = keyVault.outputs.keyVaultId
output vnetdefaultsubnetId string = virtualNetwork.outputs.subnetId
