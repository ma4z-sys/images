FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Etc/UTC

# Install required packages without interactive prompts
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    qemu-system-x86 \
    wget \
    x11vnc \
    xvfb \
    novnc \
    websockify \
    fluxbox \
    supervisor \
    gzip \
    git \
    tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create directories
RUN mkdir -p /root/.vnc /opt/novnc /opt/vm

# Download noVNC and websockify
RUN git clone https://github.com/novnc/noVNC.git /opt/novnc && \
    git clone https://github.com/novnc/websockify.git /opt/novnc/utils/websockify

# Download and extract Windows 98 image
WORKDIR /opt/vm
RUN wget https://github.com/zenllc/VerseVM/releases/download/assets/win98-desktop.qcow2.gz && \
    gunzip win98-desktop.qcow2.gz

# Add Supervisor configuration inline
RUN echo "[supervisord]\nnodaemon=true\n\n\
[program:xvfb]\ncommand=/usr/bin/Xvfb :0 -screen 0 1024x768x16\nautorestart=true\n\n\
[program:fluxbox]\ncommand=/usr/bin/fluxbox -display :0\nautorestart=true\n\n\
[program:x11vnc]\ncommand=/usr/bin/x11vnc -display :0 -nopw -forever -rfbport 5900\nautorestart=true\n\n\
[program:novnc]\ncommand=/opt/novnc/utils/launch.sh --vnc localhost:5900 --listen 8080\nautorestart=true\n\n\
[program:qemu]\ncommand=qemu-system-x86_64 -hda /opt/vm/win98-desktop.qcow2 -m 128 -vga cirrus -display vnc=:0\nautorestart=true" \
    > /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8080

CMD ["/usr/bin/supervisord"]
