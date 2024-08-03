# Overview

The bicep template provisions an Azure Linux Virtual machine.

# Project Local Testing Guide

This README provides guidance on how to locally test and deploy Azure resources using Bicep templates.

## Prerequisites
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Bicep](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)
- [SSH Key Pair fo Azure VM](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/mac-create-ssh-keys#create-an-ssh-key-pair)

## Generating an SSH Key Pair

If you don't already have an SSH key pair, you can generate one using the ssh-keygen command on Linux, macOS, or Windows Subsystem for Linux (WSL). Windows users can also use PuTTYgen or the same ssh-keygen command if Git Bash is installed.

```bash
ssh-keygen -t rsa -b 2048 -C "email address" -f "./id_rsa"
```

## Authenticate to Azure

Log into Azure CLI and Set the Azure subscription


```bash
az login

az account set --subscription "<SubscriptionID>"
```

## Validate the Bicep Template

Validate your Bicep template to ensure it is free of syntax errors.
**Note** Our Template is subscription scoped
```bash
az deployment sub validate --name Deployment --location $location --template-file main.bicep --parameters parameter.bicepparam
```

## Deploy the Bicep Template

```bash
az deployment sub create --name Deployment --resource-group $location --template-file main.bicep --parameters parameter.bicepparam
```

## Troubleshooting

Review error messages closely. Common issues include missing parameters or incorrect resource configurations.