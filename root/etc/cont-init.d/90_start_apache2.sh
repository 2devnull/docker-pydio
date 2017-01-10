#!/bin/bash

rm /etc/apache2/sites-available/default-ssl.conf
cp /config/ssl/default-ssl.conf /etc/apache2/sites-available/.

a2enmod ssl
a2ensite default-ssl
a2dissite 000-default

sed -i -e 's|//define("AJXP_FORCE_SSL_REDIRECT", true);|define("AJXP_FORCE_SSL_REDIRECT", true);|' \
	/etc/pydio/bootstrap_conf.php

service apache2 start
