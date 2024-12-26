# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Update package list and install necessary dependencies
RUN apt-get update && apt-get install -y curl git bash

# Install Bun using curl
RUN curl -fsSL https://bun.sh/install | bash

# Set the working directory for the app
WORKDIR /app/data

# Copy the start script into the container
COPY start.sh /usr/local/bin/start.sh

# Set the necessary permissions for the start script
RUN chmod +x /usr/local/bin/start.sh

# Set the command to run the start script when the container starts
CMD ["/usr/local/bin/start.sh"]
