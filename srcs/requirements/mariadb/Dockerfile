#image base
FROM debian:buster

#dependencies
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y mariadb-server
RUN apt-get install -y mariadb-client
RUN apt-get install -y procps

#replace the mariadb configuration file by our own
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

#stock unix sockets
RUN mkdir -p /var/run/mysqld

#database going to be stocked on this folder
RUN mkdir -p /var/lib/mysql

#ensure that the mariadb processes have the necessary permissions to access their respective directories
RUN chown mysql:mysql /var/run/mysqld/
RUN chmod --recursive 755 /var/run/mysqld/
RUN chown mysql:mysql /var/lib/mysql/
RUN chmod --recursive 755 /var/lib/mysql/

#listening on port 3306 to establish communication with the wp container
EXPOSE 3306

#copy our autoconfig script at the root of container and give it execution privilege 
COPY ./tools/autocondig.sh ./
RUN chmod 755 ./autocondig.sh

#execute our script at the container's launch
ENTRYPOINT ["bash", "./autocondig.sh"]
