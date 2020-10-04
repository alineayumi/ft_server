#!bin/bash

# Giving 
# Create ft_server folder
mkdir /var/www/localhost
chown -R www-data /var/www/*
chmod -R 755 /var/www/*

echo " --------------- "
echo "| SETTING NGINX |"
echo " --------------- "
mv /tmp/nginx.conf /etc/nginx/sites-available/localhost
mv /tmp/index.html var/www/localhost/
ln -s /etc/nginx/sites-available/localhost etc/nginx/sites-enabled/localhost
rm -rf /etc/nginx/sites-enabled/default

service nginx restart

echo "[ NGINX STATUS ]"
nginx -t
service nginx status
echo ""

echo "[ LINKS & COMMANDS ]"
echo "docker build -t ft_server ."
echo "docker run --name ft_server -d -p 8080:80 -p ft_server"
echo "https://localhost"

bash