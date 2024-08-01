param keyVault object
param tags object
param location string

resource keyVaultResource 'Microsoft.KeyVault/vaults@2022-07-01' = {
  name: keyVault.name
  location: location
  properties: {
    enableRbacAuthorization: true
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().tenantId
    accessPolicies: []
  }
  tags: tags
}

output keyVaultId string = keyVaultResource.id
