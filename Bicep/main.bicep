targetScope = 'subscription'

param resourceGroupParam object
param vmNameParam string
param adminUsernameParam string
param sshPublicKeyParam string
param vmSizeParam string
param vnetAddressPrefixParam string
param subnetAddressPrefixParam string
param locationParam string
param imageReferenceParam object
param keyVaultParam object
param tagsParam object = {}

var serviceName = 'selfhostedagent'

module resourceGroup 'Modules/resource-group.bicep' = {
  name: '${serviceName}-resourceGroup'
  scope: subscription()
  params: {
    resourceGroup: resourceGroupParam
    tags: tagsParam
  }
}

module virtualMachine 'Modules/virtual-machine.bicep' = {
  name: '${serviceName}-virtualMachine'
  scope: resourceGroup(resourceGroupParam.name)
  dependsOn: [
    resourceGroup
  ]
  params: {
    vmName: vmNameParam
    adminUsername: adminUsernameParam
    sshPublicKey: sshPublicKeyParam
    vmSize: vmSizeParam
    vnetAddressPrefix: vnetAddressPrefixParam
    subnetAddressPrefix: subnetAddressPrefixParam
    location: locationParam
    imageReference: imageReferenceParam
    tags: tagsParam
  }
}

module keyVault 'Modules/key-vault.bicep' = {
  scope: resourceGroup(resourceGroupParam.name)
  dependsOn: [
    resourceGroup
  ]
  name: '${serviceName}-keyVault'
  params: {
    keyVault: keyVaultParam
    location: resourceGroupParam.location
    vmPrincipalId: virtualMachine.outputs.principalId
    tags: tagsParam
  }
}
