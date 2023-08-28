#base image
FROM debian:buster

#dependencies
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y wget
RUN apt-get install -y php7.3 php-fpm php-mysql

#wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod 755 wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

#get mysql-client && mariadb-client
RUN apt-get update && apt-get install -y default-mysql-client
RUN apt-get install -y mariadb-client

#get srcs of wp and extract it in '/var/www/html'
RUN wget https://wordpress.org/wordpress-6.1.1.tar.gz -P /var/www/html
RUN cd /var/www/html \
	&& tar -xzf /var/www/html/wordpress-6.1.1.tar.gz \
	&& rm /var/www/html/wordpress-6.1.1.tar.gz

#ensure that the nginx server can fully access and modify the website's files
RUN chown --recursive www-data:www-data /var/www/*
RUN chmod --recursive 755 /var/www/*

#listening on port 9000
EXPOSE 9000

#copy our autoconfig script at the root of container and give it execution privilege 
COPY ./tools/autoconfig.sh ./
RUN chmod 755 ./autoconfig.sh

#replace the php configuration file by our own
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

#execute our script at the container's launch
ENTRYPOINT ["bash", "./autoconfig.sh"]