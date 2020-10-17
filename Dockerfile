# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: afukuhar <afukuhar@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/24 14:59:24 by afukuhar          #+#    #+#              #
#    Updated: 2020/10/17 14:08:21 by afukuhar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Installing container OS - debian buster
# https://hub.docker.com/_/debian

FROM debian:buster

ENV AUTOINDEX on

# Installing secondary packages
RUN apt-get update && apt-get install -y \
curl apt-utils vim wget openssl

# Installing nginx
RUN apt-get update && apt-get install -y nginx

# Installing php packages for nginx and wordpress
RUN apt-get update && apt-get install -y \
php-fpm php-common php-mbstring php-xmlrpc php-soap php-gd php-xml php-intl \
php-mysql php-cli php-ldap php-zip php-curl

# SSL key
RUN		mkdir /etc/nginx/ssl
COPY	srcs/openssl/openssl.conf /etc/nginx/ssl/
RUN		openssl req -newkey rsa:4096 \
            -x509 \
            -sha256 \
            -days 365 \
            -nodes \
            -out /etc/nginx/ssl/localhost.pem \
            -keyout /etc/nginx/ssl/localhost.key \
			-config /etc/nginx/ssl/openssl.conf

# MARIADB
RUN		apt-get update && apt-get install -y mariadb-server
RUN		mkdir /etc/nginx/maria-db
COPY	srcs/maria-db/create_script.sql etc/nginx/maria-db/
RUN		service mysql start && mysql -u root < etc/nginx/maria-db/create_script.sql

# NGINX
# Give nginx user-group rights over page files
RUN		chown -R www-data /var/www/*
# Change permissions for folders
RUN		chmod -R 755 /var/www/*
# Create server folder
RUN		mkdir /var/www/localhost

COPY	srcs/nginx/nginx.conf /etc/nginx/sites-available/localhost
COPY	srcs/php/info.php /var/www/localhost/
COPY	srcs/index.html /tmp/
RUN		ln -s /etc/nginx/sites-available/localhost etc/nginx/sites-enabled/localhost
RUN		rm -rf /etc/nginx/sites-enabled/default

# SETTING PHPMYADMIN
RUN		mkdir /var/www/localhost/phpmyadmin
RUN		wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
RUN		tar -xvf phpMyAdmin-5.0.4-all-languages.tar.gz --strip-components 1 -C /var/www/localhost/phpmyadmin
COPY	srcs/php/phpmyadmin.inc.php /var/www/localhost/phpmyadmin/config.inc.php

# SETTING WORDPRESS
RUN		cd /tmp
RUN		wget -c https://wordpress.org/latest.tar.gz
RUN		tar -xvzf latest.tar.gz
RUN		mv wordpress/ /var/www/localhost
COPY	srcs/wordpress/wp-config.php /var/www/localhost/wordpress

# Run after settings
COPY	srcs/run_ftserver.sh .
RUN		chmod -R 775 run_ftserver.sh
CMD		./run_ftserver.sh && tail -f /dev/null

EXPOSE 80 443