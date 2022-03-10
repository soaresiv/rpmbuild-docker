# rpmbuild-docker

This repo contains a small example to build RPM with Docker<br>
RPM makes it easier for you to distribute, manage, and update software that you create for Red Hat Linux, CentOS, and Fedora.

## How to run

Build an image using the Dockerfile:

```bash
docker build \
--build-arg USER=${USER} \
--build-arg UID=$(id -u) \
--build-arg GID=$(id -g) \ 
--build-arg PW=docker \
--tag rpm-build \
--file Dockerfile
```

Run the `BuildRPM.sh` script in a new container and automatically remove the container when it exits

```bash
docker run \
--rm=true  \
--name build-cnt \
--volume <path/to/the/output>:/artifacts  \
--volume <path/to/the/rpmbuild-docker>:/code  \
rpm-build:latest /code/BuildRPM.sh
```

## Docs

["RPM Packaging Guide"](https://rpm-packaging-guide.github.io/#introduction)
