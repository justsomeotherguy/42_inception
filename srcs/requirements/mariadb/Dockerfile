# image to base docker from
FROM debian:buster

# commands to update and install mariadb from apt repository
RUN apt-get update
RUN apt install -y mariadb-server

# copy the docker version of mysql server configuration file to host mariadb conf location
COPY ./tools/50-server.cnf /etc/mysql/mariadb.conf.d/

# copy and execute a script to assist with installation of mysql
COPY ./tools/script.sh /
RUN chmod +x /script.sh

ENTRYPOINT ["/script.sh"]
