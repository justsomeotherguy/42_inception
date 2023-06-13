#!/bin/sh

mysql_install_db

/etc/init.d/mysql start

# check if installation exists

if [ -d "/var/lib/mysql/$DB_NAME" ]
then
		echo "Database already exists"
else

# preset commands to install mysql with root password set

mysql_secure_installation << _EOF_

Y
TheBestPassword123456
TheBestPassword123456
Y
n
Y
Y
_EOF_

# set root to allow 127.0.0.1 connections
echo "GRANT ALL ON *.* to 'root'@'%' IDENTIFIED BY '$DB_ROOT_PWD';" | mysql -uroot
echo "FLUSH PRIVILEGES;" | mysql -uroot

# create database
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" | mysql -uroot

# add user to database with credentials
echo "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';" | mysql -uroot
echo "FLUSH PRIVILEGES;" | mysql -uroot

mysql -uroot -p$DB_ROOT_PASSWORD $DB_NAME < /usr/local/bin/wordpress.sql

fi

/etc/init.d/mysql stop

exec "$@"
