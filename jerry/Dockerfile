FROM postgis/postgis:15-3.4-alpine

# ========================
# Install pg_partman
# @see https://gist.github.com/jgould22/3280fc0f531485f4fe19a2ef1ef67361
ENV PG_JOBMON_VERSION v1.4.1
ENV PG_PARTMAN_VERSION v4.7.1

# Change to tuna mirror
RUN set -ex \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

# Install pg_jobmon
RUN set -ex \
    \
    # Get some basic deps required to download the extensions and name them fetch-deps so we can delete them later
    && apk add --no-cache --virtual .fetch-deps \
        ca-certificates \
        openssl \
        tar \
    \
    # Download pg_jobmon
    && wget -O pg_jobmon.tar.gz "https://github.com/omniti-labs/pg_jobmon/archive/$PG_JOBMON_VERSION.tar.gz" \
    # Make a dir to store the src files
    && mkdir -p /usr/src/pg_jobmon \
    # Extract the src files
    && tar \
        --extract \
        --file pg_jobmon.tar.gz \
        --directory /usr/src/pg_jobmon \
        --strip-components 1 \
    # Delete the src tar
    && rm pg_jobmon.tar.gz \
    \
    # Get the depends required to build pg_jobmon and name this set of depends build-deps so we can delete them later
    && apk add --no-cache --virtual .build-deps \
        autoconf \
        automake \
        g++ \
        clang15 \
        llvm15 \
        libtool \
        libxml2-dev \
        make \
        perl \
    # Change to the src
    && cd /usr/src/pg_jobmon \
    # Build the extenison
    && make \
    # Install the extension
    && make install \
    # Return to home so we are ready for the next step
    && cd / \
    # Delete the src files from this step
    && rm -rf /usr/src/pg_jobmon

# Install pg_partman
RUN set -ex \
    # Download pg_partman
    && wget -O pg_partman.tar.gz "https://github.com/pgpartman/pg_partman/archive/$PG_PARTMAN_VERSION.tar.gz" \
    # Create a folder to put the src files in
    && mkdir -p /usr/src/pg_partman \
    # Extract the src files
    && tar \
        --extract \
        --file pg_partman.tar.gz \
        --directory /usr/src/pg_partman \
        --strip-components 1 \
    # Delete src file tar
    && rm pg_partman.tar.gz \
    # Move to src file folder
    && cd /usr/src/pg_partman \
    # Build the extension
    && make \
    # Install the extension
    && make install \
    # Delete the src files for pg_partman
    && rm -rf /usr/src/pg_partman \
    # Delete the dependancies for downloading and building the extensions, we no longer need them
    && apk del .fetch-deps .build-deps

COPY initdb-partman.sh /docker-entrypoint-initdb.d/initdb-partman.sh

# ========================
# Jerry init
COPY initdb-jerry.sh /docker-entrypoint-initdb.d/initdb-jerry.sh
