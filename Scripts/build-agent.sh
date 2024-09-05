#!/bin/bash
set -e

# Select a default agent version if one is not specified
if [ -z "$AZP_AGENT_VERSION" ]; then
  AZP_AGENT_VERSION=3.243.1
fi

# Verify Azure Pipelines token is set
if [ -z "$AZP_TOKEN" ]; then
  echo 1>&2 "error: missing AZP_TOKEN environment variable"
  exit 1
fi

# Verify Azure DevOps URL is set
if [ -z "$AZP_URL" ]; then
  echo 1>&2 "error: missing AZP_URL environment variable"
  exit 1
fi

# Create a working directory to Download and extract the agent package to
mkdir -p $HOME/agentpool

# Move to the working directory
cd $HOME/agentpool

# Download the agent package to the working directory
curl https://vstsagentpackage.azureedge.net/agent/$AZP_AGENT_VERSION/vsts-agent-linux-x64-$AZP_AGENT_VERSION.tar.gz > vsts-agent-linux-x64-$AZP_AGENT_VERSION.tar.gz

# Extract the agent package 
tar zxvf vsts-agent-linux-x64-$AZP_AGENT_VERSION.tar.gz

# Create the working directory for the agent service to run jobs under
if [ -n "$AZP_WORK" ]; then
  mkdir -p "$AZP_WORK"
fi

./config.sh --unattended \
  --agent "${AZP_AGENT_NAME:-$(hostname)}" \
  --url "$AZP_URL" \
  --auth PAT \
  --token "$AZP_TOKEN" \
  --pool "${AZP_POOL:-Default}" \
  --work "${AZP_WORK:-_work}" \
  --replace \
  --acceptTeeEula

# Install and start the agent service
sudo ./svc.sh install
sudo ./svc.sh start

#remove downloaded tar file
rm vsts-agent-linux-x64-$AZP_AGENT_VERSION.tar.gz