FROM alpine:3.4

MAINTAINER xaionaro@gmail.com
ENV VERSION 0.5

# Run-time Dependencies

RUN apk upgrade --update
#ENV RUNTIME_PKGS="nagios nagios-plugins busybox rsync perl gd zlib libpng jpeg freetype mysql perl-plack findutils"
ENV RUNTIME_PKGS="nagios nagios-web nagios-plugins php5-fpm php5-xml fcgiwrap busybox openssh-client mailx postfix curl"
#ENV BUILDTIME_PKGS="alpine-sdk"

# Run-time dependencies
RUN apk --no-cache add $RUNTIME_PKGS
RUN sed -e 's/127.0.0.1:9000/0.0.0.0:9001/g' -i /etc/php5/php-fpm.conf

# To permit "su -l nagios -c" and therefore to do not install "sudo"
RUN sed -re 's%^(nagios.*)/sbin/nologin%\1/bin/sh%g' -i /etc/passwd

# This option is to permit static files. But it's bad by security reasons. Required to discuss a better way. Should we add one more NGINX instance to bypass this problem?
RUN sed -e 's/;security.limit_extensions =.*/security.limit_extensions =/g' -i /etc/php5/php-fpm.conf

RUN touch /etc/php5/fpm.d/dummy.conf

ADD start_nagios.sh /bin

CMD /bin/start_nagios.sh
