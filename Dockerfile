FROM ubuntu:bionic
LABEL maintainer="seekworser1963@gmail.com"

ARG deb_file="timetagger_2.4.4-1_bionic_amd64.deb"
ARG host_display

ENV DEB_FILE=${deb_file} \
  DEBIAN_FRONTEND=noninteractive \
  DISPLAY=${host_display}

COPY ${deb_file} /

RUN \
  sed -i.bak -e "s%http://[^ ]\+%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list && \
  apt -y update && \
  apt -y --no-install-recommends install \
  libboost-thread-dev \
  python-numpy \
  python3-numpy \
  xorg && \
  dpkg --force-architecture -i $DEB_FILE && rm $DEB_FILE && apt-get -f install && \
  # apt remove -y --purge python-numpy python3-numpy && \
  apt autoremove -y && \
  rm -rf /var/lib/apt/lists/*

CMD ["timetagger"]
