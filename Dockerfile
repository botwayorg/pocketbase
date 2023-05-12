FROM botwayorg/pb-core:latest AS download
FROM alpine:latest

ENV PKGS="git npm build-base ca-certificates"
ENV CMD="/usr/local/bin/pocketbase serve --http=0.0.0.0:8090 --dir=/root/.pocketbase"
ENV DB="pocketbase"

ARG GITHUB_TOKEN

RUN apk update && apk add --update $PKGS && rm -rf /var/cache/apk/* && npm i -g npm@latest @botway/strg@latest

COPY --from=download /pocketbase /usr/local/bin/pocketbase

EXPOSE 8090

ENTRYPOINT strg --check && strg --sync
