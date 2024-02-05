####################################
#   Multi-stage build
#       1. build ycsb
#       2. build ycsb client
####################################

# Stage 1 - Build YCSB

FROM maven:3.5 as ycsb-builder

LABEL maintainer="tjveil@gmail.com"

ARG GIT_BRANCH=master

RUN mkdir -v /opt/ycsb \
    && git clone git@github.com:jixie-wish/YCSB.git /opt/ycsb \
    && cd /opt/ycsb \
    && git checkout -f ${GIT_BRANCH} \
    && mvn -pl site.ycsb:mongodb-binding -am clean package -DskipTests=true


# Stage 2 - Build YCSB client

FROM openjdk:8-jdk-slim

LABEL maintainer="tjveil@gmail.com"

ARG POSTGRESQL_JDBC_VERSION=42.2.12

RUN apt-get update \
    && apt-get install -y python curl \
    && mkdir -v /opt/ycsb

COPY --from=ycsb-builder  /opt/ycsb/jdbc/target/ycsb-mongodb-binding-*-SNAPSHOT.tar.gz /opt/ycsb/ycsb.tar.gz

RUN tar -xvf /opt/ycsb/ycsb.tar.gz -C /opt/ycsb --strip-components=1 \
    && rm -rfv /opt/ycsb/ycsb.tar.gz

COPY db.properties /opt/ycsb/conf/db.properties
COPY ./aws-poc-workloads/* /opt/ycsb/workloads

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]


