#!/bin/bash

# fix php.ini
 sed -i \
        -e "s@\output_buffering =.*@\output_buffering = \off@g" \
        -e "s/post_max_size =.*$/post_max_size = 2048M/" \
        -e "s/upload_max_filesize =.*$/upload_max_filesize = 2048M/" \
                /etc/php/7.0/apache2/php.ini

