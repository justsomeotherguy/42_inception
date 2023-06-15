# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jwilliam <jwilliam@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/06/15 15:13:49 by jwilliam          #+#    #+#              #
#    Updated: 2023/06/15 15:33:18 by jwilliam         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all:
	@sudo mkdir -p /home/jwilliam/data/wordpress
	@sudo mkdir -p /home/jwilliam/data/mysql
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

re: 
	@sudo mkdir -p /home/jwilliam/data/wordpress
	@sudo mkdir -p /home/jwilliam/data/mysql
	@docker compose -f ./srcs/docker-compose.yml up -d --build

clean:
	@docker stop $$(docker ps -qa)
	docker rm $$(docker ps -qa)
	docker rmi -f $$(docker images -qa)
	docker volume rm $$(docker volume ls -q)
	@sudo rm -rf /home/jwilliam/data/mysql
	@sudo rm -rf /home/jwilliam/data/wordpress

.PHONY: all down re clean
