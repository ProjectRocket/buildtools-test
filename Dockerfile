FROM agapito/centos7-scala:latest

WORKDIR /root

# install deps and create testdir
RUN yum -y install make && \
    mkdir -p /root/buildtools-test

WORKDIR /root/buildtools-test

COPY build.sbt /root/buildtools-test
COPY src /root/buildtools-test/src
COPY project /root/buildtools-test/project

# run tests
CMD ["sbt", "test"]
