FROM alpine:3.11 as nekoimi-phpfpm-parent

LABEL maintainer="yangjinbo <yangjinbo@yoyohr.com>"

# 时区
ENV TZ=Asia/Shanghai
ENV PHP_VERSION 7.0.33
ENV PHP_SHA256="ab8c5be6e32b1f8d032909dedaaaa4bbb1a209e519abb01a52ce3914f9a13d96"
ENV PHP_INI_DIR /usr/local/etc/php

COPY docker-php-* /usr/local/bin/

RUN set -eux; \
	addgroup -g 1000 -S www-data; \
	adduser -u 1000 -D -S -G www-data www-data ; \
	sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories ; \
	apk add --no-cache \
	ca-certificates \
    curl \
    tar \
    xz \
    openssl ; \
    mkdir -p "$PHP_INI_DIR/conf.d"; \
    [ ! -d /var/www/html ]; \
    mkdir -p /var/www/html; \
    chown www-data:www-data /var/www/html; \
    chmod 777 /var/www/html; \
    # 创建php源码存放目录
	apk add --no-cache --virtual .fetch-deps gnupg; \
	if [ ! -d "/usr/src" ]; then \
	    mkdir -p /usr/src; \
	fi; \
	cd /usr/src; \
	if [ ! -e "/usr/src/php.tar.xz" ]; then \
        curl -L -o php.tar.xz "https://www.php.net/get/php-$PHP_VERSION.tar.xz/from/this/mirror"; \
        if [ -n "$PHP_SHA256" ]; then \
            echo "$PHP_SHA256 *php.tar.xz" | sha256sum -c -; \
        fi; \
	fi; \
	apk del --no-network .fetch-deps; \
	echo ">>>>>>>>>>>>>>>>>>>>>>>>>> 安装必要依赖 " ; \
	apk add --no-cache --virtual .build-deps \
		autoconf \
        dpkg-dev \
        dpkg \
        file \
        g++ \
        gcc \
        libc-dev \
        make \
        pkgconf \
        re2c \
		argon2-dev \
		coreutils \
		curl-dev \
		libedit-dev \
		libxml2-dev \
		bzip2-dev \
		icu-dev \
		libxslt-dev \
		openssl-dev \
		sqlite-dev \
		libmcrypt-dev \
		freetype-dev \
		libjpeg-turbo-dev \
		libpng-dev \
		gmp-dev \
		tzdata \
	; \
	cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime ; \
    echo "Asia/Shanghai" > /etc/timezone ; \
	export CFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
		CPPFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64" \
		LDFLAGS="-Wl,-O1 -Wl,--hash-style=both -pie" \
	; \
            \
	    docker-php-source extract; \
	cd /usr/src/php; \
	gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"; \
	./configure \
		--build="$gnuArch" \
		--with-config-file-path="$PHP_INI_DIR" \
		--with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
		--enable-option-checking=fatal \
		--with-mhash \
		--enable-ftp \
		--enable-mbstring \
		--with-pdo-sqlite=/usr \
		--with-sqlite3=/usr \
		--with-curl \
		--with-libedit \
		--with-openssl \
		--with-zlib \
		--enable-zip \
		--enable-opcache \
		--with-xsl \
		--with-bz2 \
        --with-jpeg-dir \
        --with-png-dir \
		--enable-fpm \
		--with-fpm-user=www-data \
		--with-fpm-group=www-data \
		--disable-cgi \
        --enable-bcmath \
        --with-mcrypt \
        --with-iconv \
        --enable-mysqlnd \
        --with-mysqli=mysqlnd \
        --with-pdo-mysql=mysqlnd \
        $(test "$gnuArch" = 's390x-linux-musl' && echo '--without-pcre-jit') \
        $(test '$(echo "$PHP_VERSION" | tr " " "\n" | sort -rV | head -n 1)' == '7.2.0' && echo '--with-password-argon2 --with-sodium=shared') ; \
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>> make && make install " ; \
	make -j "$(nproc)"; \
	find -type f -name '*.a' -delete; \
	make install; \
	find /usr/local/bin /usr/local/sbin -type f -perm +0111 -exec strip --strip-all '{}' + || true; \
	make clean; \
	if [ ! -e "/usr/local/bin/composer" ]; then \
	    curl -sS http://getcomposer.org/installer | php ; \
        mv composer.phar /usr/local/bin/composer ; \
        chmod +x /usr/local/bin/composer ; \
	fi; \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ ; \
    docker-php-ext-install -j 2 gd ; \
    docker-php-ext-install -j 2 gmp ; \
	cp -v php.ini-* "$PHP_INI_DIR/"; \
	if [ -e "$PHP_INI_DIR/php.ini-production" ]; then \
	    mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"; \
        sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 10M/g' "$PHP_INI_DIR/php.ini";\
        sed -i 's/post_max_size = 8M/post_max_size = 10M/g' "$PHP_INI_DIR/php.ini";\
        sed -i 's/;opcache.file_cache=/opcache.file_cache=\/tmp/g' "$PHP_INI_DIR/php.ini";\
        sed -i 's/;opcache.huge_code_pages=1/opcache.huge_code_pages=1/g' "$PHP_INI_DIR/php.ini";\
        sed -i 's/memory_limit = 128M/memory_limit = 512M/g' "$PHP_INI_DIR/php.ini";\
	fi; \
	cd /; \
	docker-php-source delete; \
	runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)"; \
	apk add --no-cache $runDeps; \
	pecl update-channels; \
	apk del --no-network .build-deps; \
	rm -rf /tmp/pear ~/.pearrc; \
	php --version ; \
	cd /usr/local/etc; \
	if [ -d php-fpm.d ]; then \
		sed 's!=NONE/!=!g' php-fpm.conf.default | tee php-fpm.conf > /dev/null; \
		cp php-fpm.d/www.conf.default php-fpm.d/www.conf; \
	else \
		mkdir php-fpm.d; \
		cp php-fpm.conf.default php-fpm.d/www.conf; \
		{ \
			echo '[global]'; \
			echo 'include=etc/php-fpm.d/*.conf'; \
		} | tee php-fpm.conf; \
	fi; \
	{ \
		echo '[global]'; \
		echo 'error_log = /proc/self/fd/2'; \
		echo; \
		echo '[www]'; \
		echo '; if we send this to /proc/self/fd/1, it never appears'; \
		echo 'access.log = /proc/self/fd/2'; \
		echo; \
		echo 'clear_env = no'; \
		echo; \
		echo '; Ensure worker stdout and stderr are sent to the main error log.'; \
		echo 'catch_workers_output = yes'; \
	} | tee php-fpm.d/docker.conf; \
	{ \
		echo '[global]'; \
		echo 'daemonize = no'; \
		echo; \
		echo '[www]'; \
		echo 'listen = 9000'; \
	} | tee php-fpm.d/zz-docker.conf ;\
	composer self-update --clean-backups ; \
    composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ ;\
    echo ">>>>>>>>>>>>>>>>>>>>>>>>>> done. "

ENTRYPOINT ["docker-php-entrypoint"]

WORKDIR /var/www/html

STOPSIGNAL SIGQUIT

EXPOSE 9000
CMD ["php-fpm"]
