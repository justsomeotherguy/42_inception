# base image to create docker container from

FROM debian:buster

# update and install nginx and openssl from apt repository

RUN apt-get update
RUN apt-get install -y nginx 
	\ openssl

# create ssh key

RUN openssl req \
	-x509 \
	-nodes \
	-days 365 \
	-newkey rsa:2048 \
	-keyout /etc/ssl/private/jwilliam.42.fr.key \
	-out /etc/ssl/certs/jwilliam.42.fr.crt \
	-subj "CN=jwilliam"

# commands to execute to start nginx

CMD ["nginx", "-g", "daemon off"]
