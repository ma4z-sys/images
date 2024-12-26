#!/bin/bash

bun --version
# Check if the Molactyl directory exists
if [ ! -d "Molactyl" ]; then
    echo "Molactyl directory not found. Cloning repository..."
    git clone https://github.com/hydren-dev/Molactyl.git
    cd Molactyl
    bun install
else
    echo "Molactyl directory found. Skipping clone and install."
    cd Molactyl
fi

# Check if the .env file exists
if [ ! -f ".env" ]; then
    echo ".env file not found. Setting up environment variables..."

    # Prompt user for required environment variables
    read -p "Enter PANEL_URL: " PANEL_URL
    read -p "Enter PANEL_KEY: " PANEL_KEY
    read -p "Enter DISCORD_CLIENT_ID: " DISCORD_CLIENT_ID
    read -p "Enter DISCORD_CLIENT_SECRET: " DISCORD_SERCET
    read -p "Enter DISCORD_CALLBACK_URL: " DISCORD_REDIRECT
    read -p "Enter APP_NAME: " NAME
    read -p "Enter ADMIN_USERS_EMAIL (comma separated): " ADMIN_USERS_EMAIL

    # Create the .env file with user inputs
    cat > .env <<EOL
# Panel settings
PANEL_URL=${PANEL_URL}
PANEL_KEY=${PANEL_KEY}

# Auth 
DISCORD_CLIENT_ID=${DISCORD_CLIENT_ID}
DISCORD_CLIENT_SECRET=${DISCORD_SERCET}
DISCORD_CALLBACK_URL=${DISCORD_REDIRECT}
PASSWORD_LENGTH=8

# proxycheck.io API key
PROXYCHECK_KEY=0000000000000

# Session
SESSION_SECRET=examplesecret

# AFK
AFK_TIME=60

# Application
APP_NAME=${NAME}
APP_URL=http://$(curl -s ipconfig.me):$PRIMARY_PORT
APP_PORT=$PRIMARY_PORT

# Admin
ADMIN_USERS=${ADMIN_USERS_EMAIL}

# Logs
LOGS_PATH=./storage/logs/services.log
LOGS_ERROR_PATH=./storage/logs/errors.log

# Basic plan 
DEFAULT_PLAN=BASIC

# Cost store resources
CPU_COST=750
RAM_COST=500
DISK_COST=400
BACKUP_COST=250
DATABASE_COST=250
ALLOCATION_COST=500
EOL
else
    echo ".env file found. Skipping creation of .env file."
fi

# Run the application
echo "Starting the application..."
bun run $MAIN_FILE
