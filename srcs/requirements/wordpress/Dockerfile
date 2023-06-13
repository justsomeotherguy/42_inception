# create docker instance from base debian image

FROM debian:buster

# download and install required packages from apt repository

RUN apt-get update 

RUN apt-get install -y curl php php-cgi php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

#RUN rm -rf /var/lib/apt/lists/*

# create php folder to enable php service to start

#RUN mkdir /run/php

# copy config files to wordpress conf location

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

#COPY ./conf/index.php /var/www/html/wordpress/index.php

# launch script to configure wordpress

COPY ./tools/wordpress_install.sh /
RUN chmod +x /wordpress_install.sh

# open necessary bridge port

EXPOSE 9000

ENTRYPOINT ["/wordpress_install.sh" ]
