#!/bin/bash

# sed in pydio data folder locations for /data and logging
sed -i -e 's@\define("AJXP_DATA_PATH",.*@\define("AJXP_DATA_PATH", "/data/pydiodata");@g' /etc/pydio/bootstrap_context.php
sed -i -e 's@\define("AJXP_SHARED_CACHE_DIR",.*@\define("AJXP_SHARED_CACHE_DIR", "/data/pydiodata/cache");@g' /etc/pydio/bootstrap_context.php
sed -i -e 's@\define("AJXP_FORCE_LOGPATH",.*@\define("AJXP_FORCE_LOGPATH", "/data/pydiodata/log/pydio/")\;@g' /etc/pydio/bootstrap_context.php


# setting email config file.

if [ ! -f "/config/ssmtp.conf" ]; then
cp /defaults/ssmtp.conf /config/ssmtp.conf
chown abc:abc /config/ssmtp.conf
fi

cp /root/defaults/ssmtp.conf /etc/ssmtp/ssmtp.conf
