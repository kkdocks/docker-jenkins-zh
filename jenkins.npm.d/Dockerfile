FROM node:10-stretch-slim

LABEL maintainer="yangjinbo <yangjinbo@yoyohr.com>"

# system local config
RUN true \
    && sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && sed -i 's/security.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && ln -sf /usr/share/zoneinfo/PRC /etc/localtime

RUN apt-get update \
    && apt-get install -y \
    # node-sass 等编译依赖
    make gcc g++ python \
    # 命令行工具
    curl wget vim git

RUN true \
    && npm config set registry https://registry.npm.taobao.org \
    && npm install webpack -g

RUN mkdir /work

WORKDIR /work

# 给这个目录执行权限，x是执行权限
RUN chmod +x /work

VOLUME /work

EXPOSE 8000

CMD ["sh"]
