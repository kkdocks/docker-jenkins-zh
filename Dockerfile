FROM jenkinszh/jenkins-zh:2.238

LABEL maintainer="yangjinbo <yangjinbo@yoyohr.com>"

USER root

RUN true \
    && userdel www-data \
    && groupadd -g 263 www-data \
    && useradd -s /sbin/nologin www-data -d /var/www -g www-data -u 263 \
    && echo '' > /etc/apt/source.list \
    && echo 'deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib' >> /etc/apt/source.list \
    && echo 'deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib' >> /etc/apt/source.list \
    && echo 'deb-src http://mirrors.aliyun.com/debian/ stretch main non-free contrib' >> /etc/apt/source.list \
    && echo 'deb http://mirrors.aliyun.com/debian-security stretch/updates main' >> /etc/apt/source.list \
    && echo 'deb-src http://mirrors.aliyun.com/debian-security stretch/updates main' >> /etc/apt/source.list \
    && echo 'deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib' >> /etc/apt/source.list \
    && echo 'deb-src http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib' >> /etc/apt/source.list \
    && echo 'deb http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib' >> /etc/apt/source.list \
    && echo 'deb-src http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib' >> /etc/apt/source.list \
    && apt-get update \
    && apt-get install -y libltdl7