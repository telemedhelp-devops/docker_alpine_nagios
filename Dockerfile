FROM alpine:3.4

MAINTAINER richardj@bsquare.com
ENV VERSION 0.4

# Run-time Dependencies

RUN apk upgrade --update
ENV RUNTIME_PKGS="nagios nagios-plugins busybox rsync perl gd zlib libpng jpeg freetype mysql perl-plack findutils"
ENV RUNTIME_PKGS="nagios nagios-plugins busybox"

# Run-time dependencies
RUN apk add --virtual .runtime-dependencies $RUNTIME_PKGS

ADD start_nagios.sh /bin

USER nagios 

CMD /bin/start_nagios.sh
