FROM alpine:latest

ARG BUILD_DATE
ARG VERSION
LABEL build_version="RadPenguin version:- ${VERSION} Build-date:- ${BUILD_DATE}"

ENV TZ="America/Edmonton"

RUN \
 echo "**** install runtime packages ****" && \
  apk add --no-cache \
      ca-certificates \
      curl \
      ffmpeg \
      tzdata \
      vlc \
      unzip && \
  echo "**** build xteve ****" && \
  cd /tmp && \
  curl --location https://xteve.de/download/xteve_2_linux_amd64.zip -o xteve.zip && \
  unzip xteve.zip && \
  mv xteve /usr/bin/xteve && \
  chmod 0775 /usr/bin/xteve && \
 echo "**** cleanup ****" && \
 rm -rf \
    /root/go/ \
    /root/.cache/ \
    /tmp/*

HEALTHCHECK --start-period=30s CMD curl --fail http://localhost:34400/ || exit 1

ENTRYPOINT ["/usr/bin/xteve"]
CMD ["-config=/config","-branch=master"]
