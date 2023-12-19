#!/bin/bash

# Set environment variables explicitly
export USER="ubuntu"
export HOME="/home/$USER"

# Change working directory to the script location
cd "$(dirname "$0")"

# Download the code-server installation script and make it executable
curl -fsSL https://code-server.dev/install.sh > install.sh && chmod +x install.sh

# Run the code-server installation script
./install.sh

# Enable and start the code-server service for the current user using systemd
sudo systemctl enable --now code-server@$USER

# Pause execution for 1 second (to allow time for the service to start)
sleep 5

# Create a configuration file for code-server with specified settings
mkdir -p $HOME/.config/code-server
echo '''bind-addr: 0.0.0.0:8081
auth: password
password: abcd1234
cert: false''' > $HOME/.config/code-server/config.yaml

# Stop the code-server service for the current user
sudo systemctl stop code-server@$USER

# Pause execution for 2 seconds (to allow time for the service to stop)
sleep 2

# Enable and start the code-server service again for the current user
sudo systemctl enable --now code-server@$USERrver@$USER
