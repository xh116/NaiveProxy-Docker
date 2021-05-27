FROM alpine:latest

ENV NAIVEPROXY_VERSION=v90.0.4430.85-10

RUN apk add --no-cache --virtual && apk add curl binutils \
    && curl --fail --silent -L https://github.com/just-containers/s6-overlay/releases/download/v2.2.0.3/s6-overlay-amd64.tar.gz| \
      tar xzvf - -C / \
    && curl --fail --silent -L https://github.com/klzgrad/naiveproxy/releases/download/${NAIVEPROXY_VERSION}/naiveproxy-${NAIVEPROXY_VERSION}-openwrt-x86_64.tar.xz| \
      tar xJvf - -C / \
    && mv /naiveproxy-${NAIVEPROXY_VERSION}-openwrt-x86_64/naive /usr/local/bin/naive
 
ENTRYPOINT [ "naive" ] 
CMD [ "config.json" ]
