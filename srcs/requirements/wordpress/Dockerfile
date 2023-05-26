# create docker instance from base debian image

FROM debian:buster

# download and install required packages from apt repository

RUN apt-get update && apt-get -y install \
	wget \
	php \
	php-cgi \
	php-mysql \
	php-fpm \
	php-pdo \
	php-gd php-cli \
	php-mbstring \
	&& rm -rf /var/lib/apt/lists/*

# copy config files to wordpress conf location

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d

# create php folder to enable php service to start

RUN mkdir /run/php

# launch script to configure wordpress

COPY ./tools/wordpress_install.sh /usr/local/bin
ENTRYPOINT ["wordpress_install.sh"]

# open necessary bridge port

EXPOSE 9000

# set directory

WORKDIR /var/www/html/

# execute program with option

CMD ["/usr/sbin/php-fpm7.4", "-F"]

