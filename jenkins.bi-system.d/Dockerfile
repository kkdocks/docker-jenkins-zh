FROM python:3.6-stretch

#国内debian源
ADD sources.list /etc/apt/

COPY pip.conf /etc/pip.conf
COPY requirements.txt /opt/
COPY superset /usr/local/bin

# Configure environment
ENV GUNICORN_BIND=0.0.0.0:8088 \
    GUNICORN_LIMIT_REQUEST_FIELD_SIZE=0 \
    GUNICORN_LIMIT_REQUEST_LINE=0 \
    GUNICORN_TIMEOUT=60 \
    GUNICORN_WORKERS=8 \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    PYTHONPATH=/etc/superset:/home/superset:$PYTHONPATH \
    SUPERSET_REPO=apache/incubator-superset \
    SUPERSET_VERSION=${SUPERSET_VERSION} \
    SUPERSET_HOME=/var/lib/superset
ENV GUNICORN_CMD_ARGS="--workers ${GUNICORN_WORKERS} --timeout ${GUNICORN_TIMEOUT} --bind ${GUNICORN_BIND} --limit-request-line ${GUNICORN_LIMIT_REQUEST_LINE} --limit-request-field_size ${GUNICORN_LIMIT_REQUEST_FIELD_SIZE}"


# Create superset user & install dependencies
RUN /bin/cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo 'Asia/Shanghai' >/etc/timezone && \
    useradd -U -m superset && \
    mkdir /etc/superset  && \
    mkdir ${SUPERSET_HOME} && \
    chown -R superset:superset /etc/superset && \
    chown -R superset:superset ${SUPERSET_HOME} && \
    apt-get update && \
    apt-get install -y \
        build-essential \
        gcc \
        curl \
        default-libmysqlclient-dev \
        freetds-dev \
        libffi-dev \
        libldap2-dev \
        libpq-dev \
        libsasl2-dev \
        libssl1.0 \
        freetds-bin \
        python-setuptools && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/* && \
    pip install --upgrade pip setuptools==45.2.0 && \
    pip install --no-cache-dir -r /opt/requirements.txt && \
    pip install --no-cache-dir \
        Werkzeug==0.14.1 \
        flask-cors==3.0.3 \
        flask-mail==0.9.1 \
        flask-oauth==0.12 \
        flask_oauthlib==0.9.3 \
        gevent==1.2.2 \
        impyla==0.14.0 \
        infi.clickhouse-orm==1.0.2 \
        mysqlclient==1.3.7 \
        psycopg2==2.6.1 \
        pyathena==1.2.5 \
        pyhive==0.5.1 \
        pyldap==2.4.28 \
        pymssql==2.1.3 \
        redis==2.10.5 \
        sqlalchemy-clickhouse==0.1.5.post0 \
        sqlalchemy-redshift==0.7.1 && \
        chmod +x /usr/local/bin/superset-*

WORKDIR /home/superset

CMD python
