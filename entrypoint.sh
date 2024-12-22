#!/bin/bash
# Log the start of the container
echo "Container started!"
npm run configure -- --panel "$PANEL" --key "$KEY"
# Start the application
echo "Starting application..."
node index.js
