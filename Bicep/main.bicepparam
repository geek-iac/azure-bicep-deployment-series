using './main.bicep'

param resourceGroupParam = {
  name: 'azure-pipeline'
  location: 'westeurope'
}
param vmNameParam = 'selfhost-agentVM'
param adminUsernameParam = 'agentpool'
param sshPublicKeyParam = './sshkey/id_rsa.pub'
param vmSizeParam = 'Standard_D2s_v3'
param vnetAddressPrefixParam = '10.1.0.0/16'
param subnetAddressPrefixParam = '10.1.0.0/24'
param locationParam = 'westeurope'
param imageReferenceParam = {
  publisher: 'Canonical'
  offer: '0001-com-ubuntu-server-focal'
  sku: '20_04-lts-gen2'
  version: 'latest'
}
param keyVaultParam = {
  name: 'selfhost-agentKV'
}
param tagsParam = {
  application: 'azure agentpool'
  businessArea: 'infrastructure'
  dataClassification: 'general'
  environment: 'poc'
  version: '1.0.0'
}

