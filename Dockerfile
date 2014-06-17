FROM ubuntu:14.04

MAINTAINER Kai Mallea <kmallea@gmail.com>

#ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update &&\
    apt-get install -y curl lib32gcc1

# Download and extract SteamCMD
RUN mkdir -p /opt/steamcmd &&\
    cd /opt/steamcmd &&\
    curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -vxz

WORKDIR /opt/steamcmd

# Install CS:GO
ONBUILD RUN mkdir /opt/csgo
ONBUILD RUN ./steamcmd.sh \
                +login anonymous \
                +force_install_dir /opt/csgo \
                +app_update 740 validate \
                +quit

# Make server port available to host
ONBUILD EXPOSE 27015

# This container will be executable
ONBUILD WORKDIR /opt/csgo
ONBUILD ENTRYPOINT ["./srcds_run"]