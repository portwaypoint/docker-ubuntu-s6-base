FROM debian:jessie
MAINTAINER stauraum <kai.schubert@systemmanager.org>

ENV DEBIAN_FRONTEND noninteractive
ENV _clean="rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*"
ENV _apt_clean="eval apt-get clean && $_clean"

# Set your local timezone
RUN echo "Europe/Berlin" > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

# fix locale.
#RUN locale-gen de_DE.UTF-8  
#ENV LANG de_DE.UTF-8  
#ENV LANGUAGE de_DE:de  
#ENV LC_ALL de_DE.UTF-8

# Install s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.18.1.5/s6-overlay-amd64.tar.gz /tmp/
RUN tar zxf /tmp/s6-overlay-amd64.tar.gz -C / && $_apt_clean

ENTRYPOINT [ "/init" ]
