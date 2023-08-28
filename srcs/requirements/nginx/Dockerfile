#image base
FROM debian:buster

#dependencies
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y nginx
RUN apt-get install -y curl
RUN apt-get install -y openssl

#generates a self-signed ssl/tls certificate and private key
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=jucheval.42.fr/UID=jucheval"

#stock data about nginx processus
RUN mkdir -p /var/run/nginx

#replace the nginx configuration file by our own
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

#ensure that the nginx server has the necessary permissions to 
#access its respective directories (where the wp srcs files going to be stocked)
RUN chmod 755 /var/www/html
RUN chown --recursive www-data:www-data /var/www/html

#start nginx server in the foreground
CMD ["nginx", "-g", "daemon off;"]