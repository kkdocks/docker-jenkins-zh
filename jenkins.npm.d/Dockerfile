FROM node:10-alpine3.11

LABEL maintainer="yangjinbo <yangjinbo@yoyohr.com>"

RUN true \
    && npm config set registry https://registry.npm.taobao.org

RUN mkdir /work

WORKDIR /work

# 给这个目录执行权限，x是执行权限
RUN chmod +x /work

VOLUME /work

EXPOSE 8000

CMD ["sh"]
