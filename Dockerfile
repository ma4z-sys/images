FROM node:lts

WORKDIR /app/data

# Copy the start script into the container
COPY start.sh /usr/local/bin/start.sh

# Make sure the script is executable
RUN chmod +x /usr/local/bin/start.sh

# Set the script to run when the container starts
CMD ["/usr/local/bin/start.sh"]
