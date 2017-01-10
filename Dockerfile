FROM linuxserver/mariadb
MAINTAINER 2devnull

# set version label
ARG BUILD_DATE
ARG VERSION
ARG CB_DOMAIN
ARG CB_SUB_DOMAIN
ARG CB_EMAIL

LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# copy sources.list
COPY sources.list /etc/apt/

RUN apt-get update -q \
 && apt-get install wget apt-transport-https -qy

# Add Pydio repo
# Pydio Community repositories
RUN echo "deb http://download.pydio.com/pub/linux/debian/ xenial main" > /etc/apt/sources.list.d/pydio.list \
 && wget -qO - https://download.pydio.com/pub/linux/debian/key/pubkey | apt-key add - \
 && apt-get update -q


# set install packages as variable
ENV APTLIST="\
	tar \
	unzip \
	nano \
	git \
	pydio \
	ssmtp"

# install packages
RUN \
 apt-get install \
	$APTLIST -qy && \

# install certbot for Let's Encrypt
# set -x \
# && mkdir -p /usr/local/sbin \
# && cd /usr/local/sbin \
# && curl -fsSLO https://dl.eff.org/certbot-auto \
# && chmod a+x certbot-auto \
# && ln -s certbot-auto letsencrypt-auto \
# && ./letsencrypt-auto --help all \
# && ./letsencrypt-auto --non-interactive --agree-tos --email $CB_EMAIL --apache -d $CB_DOMAIN -d $CB_SUB_DOMAIN
#  && \

# add crontab entry for Let's Encrypt
# RUN crontab -l > mycron && \
# echo "30 2 * * 1 /usr/local/sbin/letsencrypt-auto renew" >> /var/log/le-renew.log && \
# crontab mycron && \
# rm mycron


# cleanup
 apt-get clean -y && \
 apt-get autoclean -y && \
 apt-get autoremove -y && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/* \
	/usr/share/locale/* \
	/var/cache/debconf/*-old \
	/var/lib/apt/lists/* \
	/usr/share/doc/*

# delete default ssmtp config file and set ssmtp as default emailer for pydio
RUN rm \
	/etc/ssmtp/ssmtp.conf && \
 mv /usr/sbin/sendmail /usr/sbin/sendmail.org && \
 ln -s /usr/sbin/ssmtp /usr/sbin/sendmail


# add custom files
COPY root/ /


# ports and volumes
EXPOSE 443
VOLUME /config
VOLUME /data
