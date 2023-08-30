all: 
	mkdir -p /home/xel/data
	mkdir -p /home/xel/data/mariadb
	mkdir -p /home/xel/data/wordpress
	docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker compose -f ./srcs/docker-compose.yml down

clean: down
	docker system prune -af

fclean: clean
	docker volume rm srcs_mariadb srcs_wordpress
	sudo rm -rf /home/xel/data

re: fclean all

logs:
	docker logs wordpress
	docker logs mariadb
	docker logs nginx
	
ls:
	docker image ls
	docker container ls
	docker volume ls
	docker network ls

.Phony: all down clean fclean re logs ls


## mysql connexion
# docker exec -it mariadb mysql -u root -p
# SHOW DATABASES;
# USE inceptions;
# SHOW TABLES;
# SELECT * FROM wp_users;