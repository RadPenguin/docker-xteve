FROM alpine:latest

ARG BUILD_DATE
ARG VERSION
LABEL build_version="RadPenguin version:- ${VERSION} Build-date:- ${BUILD_DATE}"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL C.UTF-8
ENV TZ="America/Edmonton"
ENV REPO=xteve-project/xTeVe

RUN echo "**** install runtime packages ****" && \
  apk add --no-cache \
      ca-certificates \
      curl \
      ffmpeg \
      tzdata \
      vlc \
      unzip

RUN echo "**** download xteve ****" && \
  curl --location --silent "https://github.com/xteve-project/xTeVe-Downloads/blob/master/xteve_linux_amd64.tar.gz?raw=true" | tar zx --strip-components 1 -C /usr/bin/ && \
  chmod 0775 /usr/bin/xteve

RUN echo "**** allow vlc to run as root ****" && \
  sed -i 's/geteuid/getppid/' /usr/bin/vlc

RUN echo "**** cleanup ****" && \
 rm -rf \
    /root/go/ \
    /root/.cache/ \
    /tmp/*

HEALTHCHECK --start-period=30s CMD curl --fail http://localhost:34400/ || exit 1

ENTRYPOINT ["/usr/bin/xteve"]
CMD ["-config=/config","-branch=master"]
