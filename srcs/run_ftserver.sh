#!bin/bash

if [ "$AUTOINDEX" = "off" ] ;
then sed -i "s/autoindex on;/autoindex off;/g" /etc/nginx/sites-available/localhost ; fi

apt-get update && apt-get -y upgrade
service mysql start
service nginx start
nginx -t
service php7.3-fpm start
service php7.3-fpm status