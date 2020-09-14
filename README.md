## project description

A super light docker MariaDB installation on top of Alpine Linux for development purposes

- MariaDB 10.4.13
- zsh

The docker image size is 181 MB.

## cool features

- MariaDB configuration files are exposed on the host.
- All changes to the config files are automatically applied (hot reload).

## start container

```bash
docker-compose up
```

## connect to database

```
hostname: localhost
port: 3306
user: root
password: 123
```

## get console to container

```bash
docker exec -it mariadb zsh
```

## build docker image

```bash
docker build -t mariadb-alpine:dev .
```

## extend the docker image

In this example, we add curl.

```bash
docker-compose up --detach
docker exec -it mariadb zsh
apk add curl
exit

docker-compose stop
docker commit mariadb mariadb-alpine-curl:dev
```

To use the new image, update the image link in the docker-compose file.

## more info about the image

    https://wiki.alpinelinux.org/wiki/MariaDB
