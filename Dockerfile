FROM alpine

ARG GOSU_VERSION=1.12
ARG KORVIKE_VERSION=0.10.0

COPY build.sh /usr/local/bin/container-build
RUN set -ex \
 && apk add --no-cache \
      bash \
 && /usr/local/bin/container-build

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint

VOLUME /data
EXPOSE 16667
CMD ["/usr/local/bin/docker-entrypoint"]
