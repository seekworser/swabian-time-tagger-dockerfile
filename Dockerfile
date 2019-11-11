FROM ubuntu:latest
LABEL maintainer="seekworser1963@gmail.com"

ARG deb_file="timetagger_2.4.4-1_bionic_amd64.deb"
ARG host_display

# ARG conda_file="Anaconda3-4.2.0-Linux-x86_64.sh"
# ENV CONDA_FILE=${conda_file}

ENV DEB_FILE=${deb_file}
ENV DEBIAN_FRONTEND noninteractive
ENV PATH /root/anaconda/bin:$PATH
ENV DISPLAY=${host_display}

COPY ${deb_file} /

RUN \
  sed -i -e "s%http://[^ ]\+%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list && \
  apt update && \
  apt upgrade -y && \
  apt -y --no-install-recommends install \
  ca-certificates curl sudo xorg dbus dbus-x11 \
  wget bzip2 python-dev python-numpy python3-numpy libboost-all-dev && \
  apt-get autoclean && \
  apt-get autoremove && \
  echo "fix installing..." && \
  apt -f install && \
  echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# install anaconda
# RUN cd ~ && \
#   curl "https://repo.continuum.io/archive/${CONDA_FILE}" -o $CONDA_FILE && \
#   bash $CONDA_FILE -b -p ~/anaconda && \
#   rm $CONDA_FILE && \
#   echo 'export PATH="/root/anaconda/bin:$PATH"' >> ~/.bashrc  && \
#   conda update conda && \
#   echo $PATH

RUN dpkg -i $DEB_FILE && rm $DEB_FILE && apt-get -f install

CMD ["/opt/swabianinstruments/timetagger/TimeTaggerServer/TimeTaggerServer"]
