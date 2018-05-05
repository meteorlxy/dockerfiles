
# Cloud9 Docker Image

## Tags and Dockerfiles

- latest [*(Dockerfile)*](https://github.com/meteorlxy/dockerfiles/blob/master/cloud9/Dockerfile)

## Usage

Sample `docker-compose.yml`

```yaml
version: '2.4'

services:
  cloud9:
    container_name: cloud9
    image: meteorlxy/cloud9:latest
    restart: always
    init: true
    ports:
      - 80:80
    volumes:
      - /path/to/workspace:/workspace
    environment:
      C9_WORKSPACE: /workspace
      C9_AUTH_USER: user
      C9_AUTH_PASSWORD: password
      TZ: Asia/Shanghai
```

- Set the `C9_AUTH_USER` and `C9_AUTH_PASSWORD` to your username and password.
- Set the `TZ` to your timezone.
- Set the volumes to your workspace

## Introduction

Cloud9 Web IDE

Official Github Repository: [`c9/core`](https://github.com/c9/core)

Base Image: [`ubuntu:latest`](https://hub.docker.com/_/ubuntu)
