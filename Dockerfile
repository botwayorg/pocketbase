FROM botwayorg/pb-core:latest AS download
FROM alpine:latest

ENV PKGS="git curl wget npm lld clang build-base ca-certificates bash-completion jq llvm" DB="pocketbase"

ENV CMD="/usr/local/bin/pocketbase serve --http=0.0.0.0:8090 --dir=/root/.pocketbase"

ARG GITHUB_TOKEN

RUN apk update && apk add --update $PKGS && rm -rf /var/cache/apk/* && npm i -g npm@latest @botway/strg@latest

COPY --from=download /pocketbase /usr/local/bin/pocketbase

WORKDIR /app

RUN strg --init && npm i

EXPOSE 8090

ENTRYPOINT ["npm", "start"]
