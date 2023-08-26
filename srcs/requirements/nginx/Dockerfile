FROM debian:buster

RUN apt-get upgrade -y && apt-get update -y
RUN apt-get install -y nginx
RUN apt-get install -y vim
RUN apt-get install -y curl
RUN apt-get install -y openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=jucheval.42.fr/UID=jucheval"

RUN mkdir -p /var/run/nginx

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

RUN chmod 755 /var/www/html

RUN chown -R www-data:www-data /var/www/html

CMD ["nginx", "-g", "daemon off;"]