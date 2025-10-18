FROM alpine:latest AS base

ENV MINETEST_GAME_VERSION=5.8.0
ENV LUANTI_TAG=5.14.0
ENV MT_WORLD=prismo

# add build dependecies
FROM base AS buildenv
RUN apk add --no-cache \
    bzip2-dev \
    build-base \
    cmake \
    curl-dev \
    doxygen \
    g++ \
    gcc \
    gd-dev \
    git \
    gmp-dev \
    hiredis-dev \
    icu-dev \
    jq \
    leveldb-dev \
    openssl-dev \
    libtool \
    make \
    ncurses-dev \
    python3-dev \
    sqlite-dev \
    zstd-dev \
    postgresql-dev

# add prometheus
WORKDIR /usr/src/
RUN git clone --recursive https://github.com/jupp0r/prometheus-cpp/ && \
    mkdir prometheus-cpp/build && \
    cd prometheus-cpp/build && \
    cmake .. \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DCMAKE_BUILD_TYPE=Release \
    -DENABLE_TESTING=0 && \
    make -j2 && \
    make install

# add luanti
WORKDIR /usr/src/
RUN git clone --recursive --depth 1 --branch ${LUANTI_TAG} https://github.com/luanti-org/luanti luanti && \
    mkdir luanti/build && \
    cd luanti/build && \
    cmake .. \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SERVER=TRUE \
    -DENABLE_PROMETHEUS=TRUE \
    -DBUILD_UNITTESTS=FALSE \
    -DBUILD_CLIENT=FALSE && \
    make -j2 && \
    make install

# add minetest_game
WORKDIR /usr/local/share/luanti
RUN git clone --depth=1 -b ${MINETEST_GAME_VERSION} https://github.com/minetest/minetest_game.git ./games/minetest_game && \
    rm -fr ./games/minetest_game/.git

FROM base AS setup

RUN apk add --no-cache \
    sqlite-libs \
    curl \
    gmp \
    libgcc \
    libpq \
    libstdc++ \
    luajit \
    ncurses-libs \
    leveldb \
    hiredis \
    && adduser -D luanti --uid 30000 -h /var/lib/luanti \
    && chown -R luanti:luanti /var/lib/luanti

WORKDIR /var/lib/luanti

COPY --from=buildenv /usr/local/share/luanti /usr/local/share/luanti
COPY --from=buildenv /usr/local/bin/luantiserver /usr/local/bin/luantiserver
COPY --from=buildenv /usr/src/luanti/minetest.conf.example /etc/luanti/minetest.conf

USER luanti:luanti

EXPOSE 30000/udp 30000/tcp

VOLUME /var/lib/luanti/worlds/${MT_WORLD}
COPY entrypoint.sh /var/lib/luanti/

# CMD ["/usr/local/bin/luantiserver", "--config", "/etc/luanti/minetest.conf", "--gameid","minetest"]
# CMD ["/entrypoint.sh"]
