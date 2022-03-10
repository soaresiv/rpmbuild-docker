FROM centos:centos7

RUN yum -y install rpm-build redhat-rpm-config make gcc git vi tar unzip rpmlint rpmdevtools && yum clean all

ARG USER=docker
ARG UID=1000
ARG GID=1000
ARG PW=docker

# Option1: Using unencrypted password/ specifying password
RUN useradd -m ${USER} --uid=${UID} && echo "${USER}:${PW}" | chpasswd

RUN mkdir /code && mkdir -p /external/shell-logger/ && ln -s /code/external/shell-logger/shell-logger /external/shell-logger/shell-logger

RUN chown --changes --silent --no-dereference --recursive ${USER}:${GID} /home/${USER}

USER ${UID}:${GID}

WORKDIR /code
