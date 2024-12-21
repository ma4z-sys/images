#!/bin/bash

# Log the start of the container
echo "Container started!"

# Check for /etc/hydra/daemon.json
if [ -f /etc/hydra/daemon.json ]; then
    echo "Configuration file found at /etc/hydra/daemon.json"
    
    # Extract panel and key from the configuration file
    panel=$(jq -r '.panel' /etc/hydra/daemon.json)
    key=$(jq -r '.key' /etc/hydra/daemon.json)

    # Check if panel and key are present
    if [ -n "$panel" ] && [ -n "$key" ]; then
        echo "Running npm run configure with panel: $panel and key: $key"
        npm run configure -- --panel "$panel" --key "$key"
    else
        echo "Error: Configuration file is missing required fields 'panel' or 'key'"
        exit 1
    fi
else
    echo "/etc/hydra/daemon.json Configuration Not found"
    exit 1
fi

# Start the application
echo "Starting application..."
node index.js
