#!/bin/sh
# create directories for wordpress and nginx
mkdir /var/www/
mkdir /var/www/html
cd /var/www/html

# remove all previous wordpress files if any exist
rm -rf *

# download php archive from repository, move to to usr/local/bin directory	
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod 777 wp-cli.phar

# move wp file to system path folder which allows execution of wp commands anywhere
mv wp-cli.phar /usr/local/bin/wp

# download latest version of wordpress to current directory
# --allow-root allows command to run as root user
wp core download --allow-root

# replace sample to actual config
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# change lines in wp-config.php to connect to database, using values from .env file
sed -i "s/database_name_here/$DB_NAME/g" wp-config.php
sed -i "s/username_here/$DB_USER/g" wp-config.php
sed -i "s/password_here/$DB_PASSWORD/g" wp-config.php
sed -i "s/localhost/$DB_HOSTNAME/g" wp-config.php

#wp config --dbhost=$DB_HOST --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --allow-root

# install wordpress and set up basic settings
wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

# set user account for wordpress with role to allow them to publish and manage posts
wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_USER_PASSWORD --allow-root

# install and activate Astra theme
wp theme install astra --activate --allow-root

# install and activate redis caching on wordpress server
# allows faster retrieval from mariadb server by storing queries in memory instead of retrieving
# queries from server again
wp plugin install redis-cache --activate --allow-root

# modify the www.conf file
# s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g command substitutes the value 9000
# for /run/php/php7.3-fpm.sock in the www.conf file
# changes the socket that php-fpm listens to from unix domain socket to tcp
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

# create the /run/php directory, used for php-fpm to store unix domain sockets
mkdir /run/php

# ensure that redis is running
wp redis enable --allow-root

#
#old and crap
#

#wget https://wordpress.org/latest.tar.gz
#tar -xzvf latest.tar.gz
#rm -rf latest.tar.gz

# replace www.conf file
		#rm -rf /etc/php/7.3/fpm/pool.d/www.conf
		#mv ./www.conf /etc/php/7.3/fpm/pool.d/
	
# read .env file and set configuration file with .env variables
		#cd /var/www/html/wordpress
		#sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
		#sed -i "s/password_here/$MYSQP_PASSWORD/g" wp-config-sample.php
		#sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
		#sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
		#mv wp-config-sample.php wp-config.php


		
# start php-fpm service, -F flag tells service to run in foreground instead of background
php-fpm7.3 -F
