FROM jenkinszh/jenkins-zh:lts

LABEL maintainer="yangjinbo <yangjinbo@yoyohr.com>"

RUN cat > /etc/apt/source.list <<END
    deb http://mirrors.aliyun.com/debian/ stretch main non-free contrib
    deb-src http://mirrors.aliyun.com/debian/ stretch main non-free contrib
    deb http://mirrors.aliyun.com/debian-security stretch/updates main
    deb-src http://mirrors.aliyun.com/debian-security stretch/updates main
    deb http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib
    deb-src http://mirrors.aliyun.com/debian/ stretch-updates main non-free contrib
    deb http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib
    deb-src http://mirrors.aliyun.com/debian/ stretch-backports main non-free contrib
    END
    && apt-get update
    && apt-get install -y libltdl7
