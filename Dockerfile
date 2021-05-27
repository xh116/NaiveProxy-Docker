# Https://github.com/xh116 modified
# thanks to https://github.com/klzgrad/naiveproxy

FROM debian:latest 

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8 \
    DEBIAN_FRONTEND noninteractive

WORKDIR /build

RUN apt-get update \
 && apt-get install -y git ninja-build python pkg-config llvm libgcc-7-dev ccache curl unzip \
 && git clone --depth 1 https://github.com/klzgrad/naiveproxy.git \
 && cd naiveproxy/src \
 && ./get-clang.sh \
 && ./build.sh
 

COPY --from=builder /build/naiveproxy/src/out/Release/naive /usr/local/bin/naive

ENTRYPOINT [ "naive" ]
CMD [ "config.json" ]
