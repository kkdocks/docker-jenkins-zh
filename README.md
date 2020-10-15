### 内网jenkins

- docker in docker 方式

> ??? docker: error while loading shared libraries: libltdl.so.7: cannot open shared object file: No such file or directory ???

- 1、 exec进入jenkins容器， 执行 apt-get update && apt-get install -y libltdl7

OR

- 2、使用自定义镜像

# Run

```bash
docker run -dit -p 8080:8080 -p 50000:50000
    -v path/jenkins_home:/var/jenkins_home \
    -v /usr/bin/docker:/usr/bin/docker \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --name jenkins
    registry.cn-shenzhen.aliyuncs.com/nekoimi/jenkinszh:with-docker
```
