FROM alpine

ARG KORVIKE_VERSION=1.0.4

COPY build.sh /usr/local/bin/container-build
RUN set -ex \
 && apk add --no-cache \
      bash \
 && /usr/local/bin/container-build

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint

VOLUME /data
EXPOSE 16667

USER znc
CMD ["/usr/local/bin/docker-entrypoint"]
