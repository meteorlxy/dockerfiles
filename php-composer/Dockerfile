FROM php:alpine

LABEL maintainer.name="meteorlxy" \
      maintainer.email="meteor.lxy@foxmail.com" \
      description="php-cli and composer image"

ENV COMPOSER_HOME="/composer" \
    COMPOSER_ALLOW_SUPERUSER=1 \
    PATH="${COMPOSER_HOME}/vendor/bin:$PATH"

RUN set -x \
  && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php --no-ansi --install-dir=/usr/bin --filename=composer \
  && php -r "unlink('composer-setup.php');" \
  && composer --ansi --version --no-interaction \
  && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
  && chmod 644 ${COMPOSER_HOME}/config.json ${COMPOSER_HOME}/auth.json \
  && chmod 777 ${COMPOSER_HOME}/cache

VOLUME ["${COMPOSER_HOME}/cache"]

WORKDIR /tmp
