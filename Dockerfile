FROM scratch

ADD https://github.com/curl/curl/releases/download/curl-7_81_0/curl-7.81.0-linux-x86_64.tar.gz /curl/
ADD https://github.com/git/git/archive/refs/tags/v2.37.1.tar.gz /git/

ADD https://bun.sh/installer /bun-installer.sh

WORKDIR /app/data

COPY start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]
