FROM scratch

ADD https://github.com/curl/curl/releases/download/curl-8_11_1/curl-8.11.1.tar.gz /curl/
ADD https://github.com/git/git/archive/refs/tags/v2.37.1.tar.gz /git/

RUN curl -fsSL https://bun.sh/install | bash

WORKDIR /app/data

COPY start.sh /usr/local/bin/start.sh

RUN chmod +x /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh"]
