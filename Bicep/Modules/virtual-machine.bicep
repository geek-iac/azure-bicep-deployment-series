param vmName string = 'ubuntuVM'
param adminUsername string = 'agentpool'
param sshPublicKey string
param vmSize string = 'Standard_D2s_v3'
param vnetAddressPrefix string = '10.1.0.0/16'
param subnetAddressPrefix string = '10.1.0.0/24'
param location string = resourceGroup().location
param tags object = {}
param imageReference object = {
  publisher: 'Canonical'
  offer: '0001-com-ubuntu-server-focal'
  sku: '20_04-lts-gen2'
  version: 'latest'
}

var networkInterfaceName = '${vmName}-nic'
var virtualNetworkName = '${vmName}-vnet'
var networkSecurityGroupName = '${vmName}-nsg'
var subnetName = 'default'


output principalId string = virtualMachineResource.identity.principalId

resource virtualNetworkResource 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: virtualNetworkName
  tags: tags
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
        }
      }
    ]
  }
}

resource subnetResource 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  name: subnetName
  properties: {
    addressPrefix: subnetAddressPrefix
  }
  parent: virtualNetworkResource
}

resource networkSecurityGroupResource 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: networkSecurityGroupName
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'AllowSSH'
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

resource networkInterfaceResource 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: networkInterfaceName
  location: location
  tags: tags
  properties: {
    ipConfigurations: [
      {
        name: '${vmName}-ipconfig'
        properties: {
          subnet: {
            id: subnetResource.id
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroupResource.id
    }
  }
}

resource virtualMachineResource 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: vmName
  location: location
  tags: tags
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
      imageReference: imageReference
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/${adminUsername}/.ssh/authorized_keys'
              keyData: sshPublicKey
            }
          ]
        }
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaceResource.id
        }
      ]
    }
  }
}
