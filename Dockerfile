FROM kalilinux/kali-rolling

# Update and install ALL Kali tools (this is huge!)
RUN apt-get update && \
    apt-get install -y kali-linux-everything && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app/data

CMD ["/bin/bash"]
