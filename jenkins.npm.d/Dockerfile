FROM node:10-alpine3.11

LABEL maintainer="yangjinbo <yangjinbo@yoyohr.com>"

RUN set -eux; \
	addgroup -g 263 -S www-data; \
	adduser -u 263 -D -S -G www-data www-data ; \
	sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories ; \
    npm config set registry https://registry.npm.taobao.org ; \
    mkdir -p /work ; \
    chown -R www-data:www-data /work

WORKDIR /work
VOLUME /work

USER www-data

CMD ["sh"]
