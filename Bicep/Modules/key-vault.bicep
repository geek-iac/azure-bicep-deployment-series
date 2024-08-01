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

resource sshKeyResource 'Microsoft.KeyVault/vaults/keys@2023-07-01' = {
  parent: keyVaultResource
  name: keyVault.sshKeyName
  tags: tags
  properties: {
    keySize: 2048
    kty: 'RSA'
    keyOps: [
      'encrypt'
      'decrypt'
      'sign'
      'verify'
      'wrapKey'
      'unwrapKey'
      'import'
    ]
    attributes: {
      enabled: true
      exportable: true
    }
  }
}

output sshKeyUri string = sshKeyResource.properties.keyUriWithVersion
output keyVaultId string = keyVaultResource.id
