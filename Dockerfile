FROM alpine:latest

ARG BUILD_DATE
ARG VERSION
LABEL build_version="RadPenguin version:- ${VERSION} Build-date:- ${BUILD_DATE}"

ENV TZ="America/Edmonton"
ENV REPO=xteve-project/xTeVe

RUN \
 echo "**** Using latest release from ${LATEST_RELEASE_URL}" && \
 echo "**** install runtime packages ****" && \
  apk add --no-cache \
      ca-certificates \
      curl \
      ffmpeg \
      tzdata \
      vlc \
      unzip && \
  echo "**** find latest release of xteve *****" && \
  LATEST_RELEASE_URL=$( curl --silent https://api.github.com/repos/${REPO}/releases/latest | grep "tarball_url"  | sed -e 's/^.*: "//' -e 's/".*//' ) && \
  echo "**** downloading ${LATEST_RELEASE_URL} ****" && \
  cd /tmp && \
  curl --location https://xteve.de/download/xteve_2_linux_amd64.zip -o xteve.zip && \
  unzip xteve.zip && \
  mv xteve /usr/bin/xteve && \
  chmod 0775 /usr/bin/xteve && \
  echo "**** allow vlc to run as root ****" && \
  sed -i 's/geteuid/getppid/' /usr/bin/vlc && \
 echo "**** cleanup ****" && \
 rm -rf \
    /root/go/ \
    /root/.cache/ \
    /tmp/*

HEALTHCHECK --start-period=30s CMD curl --fail http://localhost:34400/ || exit 1

ENTRYPOINT ["/usr/bin/xteve"]
CMD ["-config=/config","-branch=master"]
