# start mysql service

service mysql start

# create user

echo "Create User '$BDD_USER'@'%' with '$BDD_USER_PASSWORD';" | mysql

# set privileges for root and user for ip addresses

echo "GRANT ALL ON *.* TO '$BDD_USER'@'%' IDENTIFIED BY '$BDD_USER_PASSWORD';" | mysql
echo "Grant ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$BDD_USER_PASSWORD';" | mysql
echo "FLUSH PRIVILEGES;" | mysql

# create wordpress database

echo "CREATE DATABASE $BDD_NAME;" | mysql

# close mysql process and restart

kill $(cat /var/run/mysqld/mysqld.pid)
mysqld
