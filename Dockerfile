FROM kmallea/steamcmd

MAINTAINER Kai Mallea <kmallea@gmail.com>

# Game data should not persist with the container
VOLUME /opt/csgo

# Install CS:GO
RUN ./steamcmd.sh \
        +login anonymous \
        +force_install_dir /opt/csgo \
        +app_update 740 validate \
        +quit

# Make server port available to host
EXPOSE 27015

# This container will be executable
WORKDIR /opt/csgo
ENTRYPOINT ["./srcds_run"]