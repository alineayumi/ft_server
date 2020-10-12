# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: afukuhar <afukuhar@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/24 14:59:24 by afukuhar          #+#    #+#              #
#    Updated: 2020/10/12 16:27:33 by afukuhar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Installing container OS - debian buster
# https://hub.docker.com/_/debian

FROM debian:buster

RUN apt-get update && apt-get install -y \
apt-utils vim wget openssl

RUN apt-get update && apt-get install -y \
nginx \
php-fpm php-mysql

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
COPY	srcs/php/todo_list.php /var/www/localhost/
RUN		ln -s /etc/nginx/sites-available/localhost etc/nginx/sites-enabled/localhost
RUN		rm -rf /etc/nginx/sites-enabled/default

# Run after settings
COPY	srcs/run_ftserver.sh .
RUN		chmod -R 775 run_ftserver.sh
CMD		./run_ftserver.sh && tail -f /dev/null

EXPOSE 80 443