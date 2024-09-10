#!/bin/bash
set -e

# update system
sudo apt update

# Install Azure CLI
echo "Installing Azure CLI..."
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Install Python3 and Pip3
echo "Installing Python3 and pip3..."
sudo apt install -y python3 python3-pip

# Upgrade pip3 to the latest version
echo "Upgrading pip3..."
pip3 install --upgrade pip

# Ensure urllib3 is upgraded to avoid compatibility issues
echo "Upgrading urllib3 to avoid Checkov compatibility issues..."
pip3 install --upgrade urllib3

# Install Checkov using pip3
echo "Installing Checkov..."
pip3 install checkov

# Install Bicep
echo "Installing Bicep..."
curl -Lo bicep https://github.com/Azure/bicep/releases/latest/download/bicep-linux-x64
chmod +x ./bicep
sudo mv ./bicep /usr/local/bin/bicep

# Verify installations
echo "Verifying installations..."
az --version
python3 --version
pip3 --version
checkov --version
bicep --help

echo "Build tools installation completed!"
