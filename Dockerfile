# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: afukuhar <afukuhar@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/09/24 14:59:24 by afukuhar          #+#    #+#              #
#    Updated: 2020/10/01 14:26:37 by afukuhar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Installing container OS - debian buster
# https://hub.docker.com/_/debian

FROM debian:buster

RUN apt-get update && apt-get install -y \
nginx \
mariadb-server \
php-fpm php-mysql 

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]