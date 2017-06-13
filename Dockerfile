FROM postgres:alpine
RUN apk add --update --no-cache gcc musl-dev make py-pip curl && \
    pip install pgxnclient && \
    su - postgres && \
    pgxnclient install temporal_tables && \
    apk del py-pip curl gcc musl-dev make && \
    rm -rf /var/cache/apk/*
