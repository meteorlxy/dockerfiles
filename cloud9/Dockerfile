FROM krallin/ubuntu-tini:xenial

LABEL maintainer.name="meteorlxy" \
      maintainer.email="meteor.lxy@foxmail.com" \
      description="Cloud9 Web IDE image"

USER root

ENV C9_WORKSPACE="/workspace" \
    C9_AUTH_USER="user" \
    C9_AUTH_PASSWORD="password"

ARG TIMEZONE="Asia/Shanghai"
ARG NODE_VERSION="8.x"
ARG PHP_VERSION="7.2"

RUN BASE_PACKAGES="ca-certificates curl git python software-properties-common tzdata wget" \
    BUILD_PACKAGES="build-essential" \
    set -x \
      && export DEBIAN_FRONTEND=noninteractive \
      # ------------------------------------------------------------------------------
      # Install packages
      # ------------------------------------------------------------------------------
      && apt-get update \
      && apt-get install --no-install-recommends -y \
        net-tools \
        unzip \
        vim \
        zip \
        ${BASE_PACKAGES} \
        ${BUILD_PACKAGES} \
      && echo 'export LC_ALL="C.UTF-8"' >> /etc/profile \
      && echo 'export LANG="C.UTF-8"' >> /etc/profile \
      && . /etc/profile \
      && echo ${TIMEZONE} > /etc/timezone \
      && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
      # ------------------------------------------------------------------------------
      # Install Cloud9
      # ------------------------------------------------------------------------------
      && git clone --single-branch --depth 1 https://github.com/c9/core.git /cloud9 \
      && /cloud9/scripts/install-sdk.sh \
      # ------------------------------------------------------------------------------
      # Install Nodejs & npm & yarn
      # ------------------------------------------------------------------------------
      && curl -sL https://deb.nodesource.com/setup_${NODE_VERSION} |  bash - \
      && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
      && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
      && apt-get update \
      && apt-get install --no-install-recommends -y nodejs yarn \
      && npm install -g npm \
      # ------------------------------------------------------------------------------
      # Install Python & pip
      # ------------------------------------------------------------------------------
      && curl -L https://bootstrap.pypa.io/get-pip.py | python2 \
      && curl -L https://bootstrap.pypa.io/get-pip.py | python3 \
      && pip --no-cache-dir install pipenv \
      # ------------------------------------------------------------------------------
      # Install PHP & composer
      # ------------------------------------------------------------------------------
      && add-apt-repository -y ppa:ondrej/php \
      && apt-get update \
      && apt-get install --no-install-recommends -y \
        php${PHP_VERSION}-cli \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-dom \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-soap \
        php${PHP_VERSION}-xdebug \
        php${PHP_VERSION}-zip \
      && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --quiet \
      # ------------------------------------------------------------------------------
      # Install Ruby & RVM
      # ------------------------------------------------------------------------------
      && gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB \
      && curl -sSL https://get.rvm.io | bash -s stable --ruby \
      # ------------------------------------------------------------------------------
      # Cleanup
      # ------------------------------------------------------------------------------
      && apt-get purge -y ${BUILD_PACKAGES} \
      && apt-get autoremove -y \
      && apt-get autoclean -y \
      && apt-get clean -y \
      && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* /root/.cache/* /root/.c9/tmp/* /root/.c9/tmux-* /root/.c9/libevent-* /root/.c9/ncurses-* \
      && npm cache clean --force

COPY ./build/docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/tini", "--", "/docker-entrypoint.sh"]