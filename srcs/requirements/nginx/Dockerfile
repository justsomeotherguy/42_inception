# base image to create docker container from

FROM debian:buster

# update and install nginx and openssl from apt repository

RUN apt-get update
RUN apt-get install -y nginx openssl

# create self-signed ssl certificate

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/jwilliam.42.fr.key -out /etc/ssl/certs/jwilliam.42.fr.crt -subj '/C=AU/O=42/OU=42Adel/CN=jwilliam/'

# create new config snippet for nginx

RUN echo "ssl_certificate /etc/ssl/certs/jwilliam.42.fr.crt;\nssl_certificate_key /etc/ssl/private/jwilliam.42.fr.key;" > /etc/nginx/snippets/self-signed.conf

# create Diffie-Helman group

RUN openssl dhparam -out /etc/nginx/dhparam.pem 2048

# create configuration snippet with strong encryption settings

COPY ./conf/ssl-params.conf /etc/nginx/snippets

# copy nginx conf file to nginx folder

COPY ./conf/nginx.conf /etc/nginx/conf.d

# commands to execute to start nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
