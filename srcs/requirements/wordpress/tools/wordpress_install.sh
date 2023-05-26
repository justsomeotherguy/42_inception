
# check if wordpress is not already installed

if [ -f ./wordpress/wp-config.php]
	then
		echo "Wordpress is already installed"
	else
# download wordpress, extract archive then remove downloaded archive after		
		wget https://wordpress.org/latest.tar.gz
		tar -xzvf latest.tar.gz
		rm -rf latest.tar.gz

# replace www.conf file
		rm -rf /etc/php/7.4/fpm/pool.d/www.conf
		mv ./www.conf /etc/php/7.4/fpm/pool.d/
	
# read .env file and set configuration file with .env variables
		cd /var/www/html/wordpress
		sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
		sed -i "s/password_here/$MYSQP_PASSWORD/g" wp-config-sample.php
		sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
		sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
		mv wp-config-sample.php wp-config.php
fi

exec "$@"
