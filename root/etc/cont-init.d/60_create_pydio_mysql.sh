#!/usr/bin/with-contenv sh

if  pgrep "mysql" > /dev/null ; then
        echo "mysql is running"

else
	service mysql start
fi

mysql -u root -p${MYSQL_ROOT_PASSWORD} -se "USE pydio;"
	if [ $? -eq "0" ]; then
		echo "database pydio exist"
	else
	        MYSQL_DEB_SYS_PWD=$(cat /etc/mysql/debian.cnf | grep -m 1 password | sed 's/password = //g')
	        mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON *.* TO 'debian-sys-maint'@'localhost' IDENTIFIED BY '${MYSQL_DEB_SYS_PWD}';;"
		mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "create database pydio"

	fi
fi

