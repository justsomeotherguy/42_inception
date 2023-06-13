#!/bin/sh

service mysql start

# create database
echo "CREATE DATABASE $DB_NAME ;" | mysql -u root

# add user to database with credentials
echo "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD' ;" | mysql -u root
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;" | mysql -u root

# change pass to root user
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PWD' ;" | mysql -u root

# clears current cache of old privilege settings
echo "FLUSH PRIVILEGES ;" | mysql -uroot

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
