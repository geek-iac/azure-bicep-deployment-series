# Project Local Testing Guide

This README provides guidance on how to locally test and deploy Azure resources using Bicep templates.

## Prerequisites

Before proceeding, ensure you have the following installed:
- **Azure CLI**: Required for interacting with Azure from the command line.
- **Bicep CLI**: Needed to compile and manage Bicep templates.

Installation guides:
- Azure CLI: [Install Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- Bicep: [Install Bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)

## Local Testing Steps

### Step 1: Validate the Bicep Template

Validate your Bicep template to ensure it is free of syntax errors.

```bash
bicep build <your-template>.bicep
```

## Azure Login

Log into Azure CLI:

```bash
az login

```

## Set the Azure subscription

```bash
az account set --subscription "<SubscriptionID>"
```

if you dont have a resource group you can create one:

```bash
ResourceGroupName='azure-pipeline'
az group create --name $ResourceGroupName --location westeurope
```

## Generating an SSH Key Pair

If you don't already have an SSH key pair, you can generate one using the ssh-keygen command on Linux, macOS, or Windows Subsystem for Linux (WSL). Windows users can also use PuTTYgen or the same ssh-keygen command if Git Bash is installed.

```bash
ssh-keygen -t rsa -b 2048 -C "iheanacho.chukwu@outlook.com" -f "./id_rsa"
```

## Deploy Bicep Template

Deploy to your resource group:

```bash
az deployment group create --name Deployment --resource-group $ResourceGroupName --template-file virtualmachine.bicep --parameters sshPublicKey='@id_rsa.pub'
```
az deployment sub validate --location westeurope --template-file Bicep/main.bicep --parameters Bicep/main.bicepparam

az deployment sub create --location westeurope --template-file Bicep/main.bicep --parameters Bicep/main.bicepparam


## Verify Deployment

List resources in the resource group:

```bash
az resource list --resource-group $ResourceGroupName -o table
```

## Troubleshooting

Review error messages closely. Common issues include missing parameters or incorrect resource configurations.