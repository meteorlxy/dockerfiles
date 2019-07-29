FROM ubuntu:18.10

LABEL maintainer.name="meteorlxy" \
      maintainer.email="meteor.lxy@foxmail.com" \
      description="Meteorlxy Development Image"

USER root

ENV TZ="Asia/Shanghai" \
    LC_ALL="C.UTF-8" \
    LANG="C.UTF-8"

ARG NODE_VERSION="12.x"
ARG PHP_VERSION="7.3"
ARG GO_VERSION="1.12.7"

RUN APT_INSTALL="apt-get install --no-install-recommends -y" && \
    export DEBIAN_FRONTEND=noninteractive && \
    set -x && \
    # ------------------------------------------------------------------------------
    # Install base tools
    # ------------------------------------------------------------------------------
    apt-get update && \
    $APT_INSTALL \
      apt-utils \
      ca-certificates \
      curl \
      gnupg \
      git \
      htop \
      net-tools \
      openssh-server \
      software-properties-common \
      tzdata \
      unzip \
      vim \
      wget \
      zip \
      && \
    # ------------------------------------------------------------------------------
    # Install C & C++
    # ------------------------------------------------------------------------------
    apt-get update && \
    $APT_INSTALL \
      build-essential \
      cmake \
      g++ \
      gcc \
      gdb \
      make \
      && \
    # ------------------------------------------------------------------------------
    # Install Nodejs & npm & yarn
    # ------------------------------------------------------------------------------
    curl -sL https://deb.nodesource.com/setup_${NODE_VERSION} |  bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    $APT_INSTALL \
      nodejs \
      yarn \
      && \
    npm install -g npm && \
    # ------------------------------------------------------------------------------
    # Install Python 2 & Python 3 & pip & pipenv
    # ------------------------------------------------------------------------------
    apt-get update && \
    $APT_INSTALL \
      python \
      python-dev \
      python3 \
      python3-dev \
      && \
    curl -L https://bootstrap.pypa.io/get-pip.py | python2 && \
    curl -L https://bootstrap.pypa.io/get-pip.py | python3 && \
    pip --no-cache-dir install pipenv && \
    # ------------------------------------------------------------------------------
    # Install PHP & composer
    # ------------------------------------------------------------------------------
    add-apt-repository -y ppa:ondrej/php && \
    apt-get update && \
    $APT_INSTALL \
      php${PHP_VERSION}-cli \
      php${PHP_VERSION}-curl \
      php${PHP_VERSION}-dom \
      php${PHP_VERSION}-gd \
      php${PHP_VERSION}-mbstring \
      php${PHP_VERSION}-mysql \
      php${PHP_VERSION}-soap \
      php${PHP_VERSION}-xdebug \
      php${PHP_VERSION}-zip \
      && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --quiet && \
    # ------------------------------------------------------------------------------
    # Install Ruby & RVM
    # ------------------------------------------------------------------------------
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
    curl -sSL https://get.rvm.io | bash -s stable --ruby --autolibs=enable --auto-dotfiles && \
    gpasswd –a root rvm && \
    # ------------------------------------------------------------------------------
    # Install Golang
    # ------------------------------------------------------------------------------
    curl -o /tmp/${GO_VERSION}.linux-amd64.tar.gz https://dl.google.com/go/${GO_VERSION}.linux-amd64.tar.gz && \
    tar -zxf /tmp/${GO_VERSION}.linux-amd64.tar.gz -C /usr/local/ && \
    ln -s /usr/local/go/bin/go /usr/local/bin/go && \
    ln -s /usr/local/go/bin/gofmt /usr/local/bin/gofmt && \
    ln -s /usr/local/go/bin/godoc /usr/local/bin/godoc && \
    rm -f /tmp/${GO_VERSION}.linux-amd64.tar.gz && \
    /usr/local/bin/go version && \
    # ------------------------------------------------------------------------------
    # Cleanup
    # ------------------------------------------------------------------------------
    apt-get purge -y ${BUILD_PACKAGES} && \
    apt-get autoremove -y && \
    apt-get autoclean -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/* && \
    npm cache clean --force

EXPOSE 80

ENTRYPOINT ["/docker-entrypoint.sh"]
