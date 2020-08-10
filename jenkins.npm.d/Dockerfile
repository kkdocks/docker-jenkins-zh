FROM node:8-alpine3.11

LABEL maintainer="yangjinbo <yangjinbo@yoyohr.com>"

RUN set -eux; \
	addgroup -g 263 -S www-data; \
	adduser -u 263 -D -S -G www-data www-data ; \
	sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories ; \
    apk add --no-cache curl wget python2 make gcc g++ git ; \
    mkdir -p /work ; \
    chown -R www-data:www-data /work ; \
    npm config set registry https://registry.npm.taobao.org ; \
    npm config set sass_binary_site https://npm.taobao.org/mirrors/node-sass/ ; \
    npm install webpack -g ; \
    npm install -g vue-cli

WORKDIR /work
VOLUME  /work
VOLUME  /root/.npm

USER www-data

CMD ["sh"]