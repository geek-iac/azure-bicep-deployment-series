param keyVault object
param tags object
param location string

resource keyVaultResource 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: keyVault.name
  location: location
  tags: tags
  properties: {
    enableRbacAuthorization: true
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: []
  }
}

output keyVaultId string = keyVaultResource.id
