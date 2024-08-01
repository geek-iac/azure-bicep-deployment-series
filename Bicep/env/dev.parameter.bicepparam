using '../main.bicep'

param vnetParam = {
  name: 'demoiacvnet'
  addressPrefix: '10.1.0.0/16'
  subnetName: 'default'
  subnetAddressPrefix: '10.1.0.0/24'
  nsgName: 'demoiacnsg'
  networkInterfaceName: 'demoiacnic'
}

param tagsParam = {
  owner: 'nacho'
  env: 'labs'
  application: 'prettyService'
}

param keyVaultParam = {
  name: 'nachokv'
}

param vmParam = {
  name: 'ubuntuVMs'
  adminUsername: 'agentpool'
  sshPublicKey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8Ot9Mujo7oj+4fH8e8AjmYGv3Vkvrm7VLNKYh5GQ9wlG7v411ZPAIs1QCOlKWkFYjOw0jwXHTsFS5PdP2mJJ7FuFooI2km4Dkz/URam9jBxLWa3UAAc3BxcU2kgeJlmzWXSfhoeQI9A/wIfNxng2m5UWlGNNWRqB5ZwtAV/OR2yQwL3aETgzywVGQlDjLQ7cFCvkrNGtpxzuY8tZI/qjnLTMcX14wRiDGR/0U1xf+39GfxLhjV4trKi5EqwKk38amZXzjYKWfuiz35VN74a+/G/LaT0Ixu+IdFF8y+xXnN84SFZLi3nV4VaIPNc1w+v0G/SysCdPMBRno1gD3EEah iheanacho.chukwu@outlook.com'
  size: 'Standard_D2s_v3'
  imageReference: {
    publisher: 'Canonical'
    offer: '0001-com-ubuntu-server-focal'
    sku: '20_04-lts-gen2'
    version: 'latest'
  }
}

param resourceGroupUKSParam = {
  name: 'demo'
  location: 'uksouth'
}
