#!/bin/sh
service mysql start

# create database
echo "CREATE DATABASE IF NOT EXISTS $DB_NAME ;" > dbexec.sql

# create user

echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PWD' ;" >> dbexec.sql
echo "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;" >> dbexec.sql

echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '12345' ;" >> dbexec.sql

echo "FLUSH PRIVILEGES;" >> dbexec.sql

mysql < dbexec.sql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld
