FROM ubuntu:17.04

MAINTAINER Jon Quinnell <jquinnell@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update &&\
    apt-get install -y curl lib32gcc1

# Download and extract SteamCMD
RUN mkdir -p /opt/steamcmd &&\
    cd /opt/steamcmd &&\
    curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -vxz

WORKDIR /opt/steamcmd

# This container will be executable
ENTRYPOINT ["./steamcmd.sh"]

# Create insurgency directory
RUN mkdir /opt/insurgency

# Add startup script
ADD startup.sh /usr/src/app/startup.sh
RUN chmod +x /usr/src/app/startup.sh

# Make server port available to host
EXPOSE 27015

WORKDIR /opt/insurgency

# Update and run insurgency
ENTRYPOINT ["/usr/src/app/startup.sh"]

# Run in insurgency in console mode
CMD ["updaterun", "-console"]