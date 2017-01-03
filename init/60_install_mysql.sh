#!/bin/bash

if  pgrep "mysql" > /dev/null ; then
        echo "mysql is running"
else
        mysql_install_db --user=mysql --basedir=/usr/ --ldata=/var/lib/mysql/
        service mysql start
        mysql -uroot -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('pydiomysqlpwd');;"
        MYSQL_DEB_SYS_PWD=$(cat /etc/mysql/debian.cnf | grep -m 1 password | sed 's/password = //g')
        mysql -uroot -ppydiomysqlpwd -e "GRANT ALL PRIVILEGES ON *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '${MYSQL_DEB_SYS_PWD}';;"
fi

