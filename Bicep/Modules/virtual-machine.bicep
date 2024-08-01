param location string
param tags object = {}
param vm object
param subnetId string

resource networkInterfaceResource 'Microsoft.Network/networkInterfaces@2021-05-01' = {
  name: '${vm.name}-nic'
  location: location
  tags: tags
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetId
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource virtualMachineResource 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: vm.name
  location: location
  tags: tags
  properties: {
    hardwareProfile: {
      vmSize: vm.size
    }
    storageProfile: {
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
      imageReference: vm.imageReference
    }
    osProfile: {
      computerName: vm.name
      adminUsername: vm.adminUsername
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/${vm.adminUsername}/.ssh/authorized_keys'
              keyData: vm.sshPublicKey
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

output vmId string = virtualMachineResource.id
