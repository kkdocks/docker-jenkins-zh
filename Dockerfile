FROM jenkinszh/jenkins-zh:2.256

LABEL maintainer="yangjinbo <yangjinbo@yoyohr.com>"

COPY script.d/jenkins.bi-builder     /usr/bin/bi-builder
COPY script.d/jenkins.bi-npm         /usr/bin/bi-npm
COPY script.d/jenkins.bi-yarn        /usr/bin/bi-yarn
COPY script.d/jenkins.composer       /usr/bin/composer
COPY script.d/jenkins.npm            /usr/bin/npm
COPY script.d/jenkins.yarn           /usr/bin/yarn
COPY script.d/jenkins.npm12            /usr/bin/npm12
COPY script.d/jenkins.yarn12           /usr/bin/yarn12

ENV TZ Asia/Shanghai
USER root
RUN (id -u www > /dev/null 2>&1) && userdel www ; \
    echo 'done'
RUN true \
    && groupadd -g 263 www \
    && useradd -s /sbin/nologin www -d /var/www -g www -u 263 \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && rm -rf /etc/apt/sources.list \
    && echo 'deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib' > /etc/apt/sources.list \
    && echo 'deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb-src http://mirrors.aliyun.com/debian/ stretch main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb http://mirrors.aliyun.com/debian-security stretch/updates main' >> /etc/apt/sources.list \
    && echo 'deb-src http://mirrors.aliyun.com/debian-security stretch/updates main' >> /etc/apt/sources.list \
    && echo 'deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb-src http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib' >> /etc/apt/sources.list \
    && echo 'deb-src http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib' >> /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y libltdl7 \
    && chmod +x /usr/bin/bi-builder \
    && chmod +x /usr/bin/bi-npm \
    && chmod +x /usr/bin/bi-yarn \
    && chmod +x /usr/bin/composer \
    && chmod +x /usr/bin/npm \
    && chmod +x /usr/bin/yarn \
    && chmod +x /usr/bin/npm12 \
    && chmod +x /usr/bin/yarn12