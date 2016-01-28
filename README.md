# Docker-ized PhantomJS 2

A Dockerfile to build [PhantomJS](https://github.com/ariya/phantomjs) 2.1.1 for Linux from source.

## Installation
There is an [Automated Build on hub.docker.com](https://registry.hub.docker.com/u/nathanmarks/phantomjs2/):

```
docker pull nathanmarks/phantomjs2:latest
```

## Usage

```bash
docker run nathanmarks/phantomjs2 phantomjs -v
```