FROM alpine:3.4

COPY SHA256SUMS /root

RUN apk --update upgrade && apk add bash curl "postgresql<9.6" "postgresql-contrib<9.6" && \
    mkdir /docker-entrypoint-initdb.d && \
    curl -o /root/gosu-amd64 -sSL "https://github.com/tianon/gosu/releases/download/1.9/gosu-amd64" && \
    cd /root && sha256sum -c /root/SHA256SUMS && cd .. && \
    mv /root/gosu-amd64 /usr/local/bin/gosu && \
    chmod +x /usr/local/bin/gosu && \
    apk del curl && \
    rm -rf /var/cache/apk/*

ENV LANG en_US.utf8
ENV PGDATA /var/lib/postgresql/data
VOLUME /var/lib/postgresql/data

COPY docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
