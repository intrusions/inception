#!/bin/bash
cd /var/www/html/wordpress

if ! wp core is-installed; then
	#create and configure the wp-config.php file to set informations about db name and db user
	wp config create										\
				--allow-root 								\
				--dbname=${SQL_DATABASE_NAME}					\
				--dbuser=${SQL_USER}						\
				--dbpass=${SQL_PASSWORD}					\
				--dbhost=${SQL_HOST}						\
				--url=https://${DOMAIN_NAME};

	#set informations about admin user and title/url of website
	wp core install											\
				--allow-root								\
				--url=https://${DOMAIN_NAME}				\
				--title=${SITE_TITLE}						\
				--admin_user=${ADMIN_USER}					\
				--admin_password=${ADMIN_PASSWORD}			\
				--admin_email=${ADMIN_EMAIL};

	#create a simple user
	wp user create											\
				--allow-root								\
				${USER1_LOGIN} ${USER1_MAIL}				\
				--role=author								\
				--user_pass=${USER1_PASS};

	#refresh wp cache to apply the new modifications
	wp cache flush --allow-root
fi

mkdir -p /run/php;

#start the PHP FastCGI
exec /usr/sbin/php-fpm7.3 -F -R