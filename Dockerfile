# Stage 1: Build everything in a more complete Ubuntu image
FROM ubuntu:22.04 as build

# Update package list and install necessary dependencies
RUN apt-get update && apt-get install -y curl git bash

# Install Bun using curl
RUN curl -fsSL https://bun.sh/install | bash

# Stage 2: Copy files into scratch
FROM scratch

# Copy necessary binaries from the build stage into the scratch image
COPY --from=build /usr/local/bin/curl /usr/local/bin/git /usr/local/bin/bun /bin/
COPY --from=build /usr/bin/bash /bin/bash

# Copy the start script into the scratch image
COPY start.sh /usr/local/bin/start.sh

# Set the necessary permissions for the start script
RUN chmod +x /usr/local/bin/start.sh

# Set the working directory
WORKDIR /app/data

# Set the command to run the start script
CMD ["/usr/local/bin/start.sh"]
