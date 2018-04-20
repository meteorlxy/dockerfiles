
# PHP-CLI and Composer Image

Change the Composer Registry to [Packagist / Composer 中国全量镜像](https://pkg.phpcomposer.com/)

## Docker Pull

```shell
docker pull meteorlxy/php-composer:latest 
```

## Use php-cli in shell

### Add the following function to `.bashrc` or `.zshrc`

```shell
# Use php-cli via Docker Image
php () {
    docker run \
        --interactive \
        --tty \
        --rm \
        --user $(id -u):$(id -g) \
        --volume /etc/passwd:/etc/passwd:ro \
        --volume /etc/group:/etc/group:ro \
        --volume $(pwd):/tmp/php \
        -w /tmp/php \
        meteorlxy/php-composer \
        php "$@"
}
```

## Use composer in shell

### Add the following function to `.bashrc` or `.zshrc`

```shell
# Use composer via Docker Image
composer () {
    docker run \
        --interactive \
        --tty \
        --rm \
        --user $(id -u):$(id -g) \
        --volume /etc/passwd:/etc/passwd:ro \
        --volume /etc/group:/etc/group:ro \
        --volume ~/.composer/cache:/composer/cache:rw \
        --volume $(pwd):/tmp/composer \
        -w /tmp/composer \
        meteorlxy/php-composer \
        composer "$@"
}

```
**Attention**

1. When running `composer install`, consider the `--ignore-platform-reqs` and `--no-scripts` flags.

2. The line `--volume ~/.composer/cache:/composer/cache:rw` will store the cache in your host machine. Delete it if you don't need cache

