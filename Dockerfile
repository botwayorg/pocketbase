FROM alpine:latest as download

RUN apk add curl

RUN curl -s https://get-latest.deno.dev/pocketbase/pocketbase?no-v=true >> tag.txt

RUN wget https://github.com/pocketbase/pocketbase/releases/download/v$(cat tag.txt)/pocketbase_$(cat tag.txt)_linux_amd64.zip \
    && unzip pocketbase_$(cat tag.txt)_linux_amd64.zip \
    && chmod +x /pocketbase

FROM alpine:latest

RUN apk update && apk add --update git build-base ca-certificates && rm -rf /var/cache/apk/*

COPY --from=download /pocketbase /usr/local/bin/pocketbase

EXPOSE 8090

ENTRYPOINT /usr/local/bin/pocketbase serve --http=0.0.0.0:8090 --dir=/root/pocketbase
