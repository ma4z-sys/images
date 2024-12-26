# Start with the latest Ubuntu image
FROM ubuntu:latest

# Update package list and install required packages, including sudo
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    sudo \
    coreutils && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Change the working directory to /app/data
WORKDIR /app/data

# Set up the environment to make it appear as if /app/data is the root
ENV HOME=/app/data
ENV PS1="\u@\h:\W\$ "

# Create symlinks for root-level directories in /app/data
RUN for dir in bin etc lib lib64 sbin usr var opt; do \
        mkdir -p /app/data/$dir && \
        ln -sfn /app/data/$dir /$dir; \
    done && \
    mkdir -p /app/data/root && ln -sfn /app/data/root /root

COPY start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]
