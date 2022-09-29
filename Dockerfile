FROM alpine:latest as download

RUN curl -s https://get-latest.onrender.com/pocketbase/pocketbase/no-v >> tag.txt

RUN wget https://github.com/pocketbase/pocketbase/releases/download/v$(cat tag.txt)/pocketbase_$(cat tag.txt)_linux_amd64.zip \
    && unzip pocketbase_$(cat tag.txt)_linux_amd64.zip \
    && chmod +x /pocketbase

FROM alpine:latest

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

EXPOSE 8090

COPY --from=download /pocketbase /usr/local/bin/pocketbase

ENTRYPOINT ["/usr/local/bin/pocketbase", "serve", "--http=0.0.0.0:8090", "--dir=/pb_data"]
