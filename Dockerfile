FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app/data

ENV HOME=/app/data
ENV PS1="\u@\h:\W\$ "

RUN for dir in /bin /etc /lib /lib64 /sbin /usr /var /opt; do \
        mkdir -p /app/data$dir && \
        ln -sfn /app/data$dir $dir; \
    done && \
    mkdir -p /app/data/root && ln -sfn /app/data/root /root

COPY start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]
