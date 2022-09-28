FROM alpine as downloader

RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.7.6/pocketbase_0.7.6_linux_amd64.zip \
    && unzip pocketbase_0.7.6_linux_amd64.zip \
    && chmod +x /pocketbase

FROM alpine

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

EXPOSE 8090

COPY --from=downloader /pocketbase /usr/local/bin/pocketbase
ENTRYPOINT ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:8090", "--dir=/pb_data"]
