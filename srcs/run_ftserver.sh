#!bin/bash

# Give nginx user-group rights over page files
chown -R www-data /var/www/*

# Change permissions for folders
chmod -R 755 /var/www/*

# Create server folder
mkdir /var/www/localhost

echo " --------------- "
echo "| SETTING NGINX |"
echo " --------------- "
mv /tmp/nginx.conf /etc/nginx/sites-available/localhost
mv /tmp/index.html var/www/localhost/
ln -s /etc/nginx/sites-available/localhost etc/nginx/sites-enabled/localhost
rm -rf /etc/nginx/sites-enabled/default

# Restart nginx after settings
service nginx restart

echo " -------------- "
echo "| NGINX STATUS |"
echo " -------------- "
nginx -t
service nginx status
echo ""

echo "[ LINKS & COMMANDS ]"
echo "docker build -t ft_server ."
echo "docker run --name ft_server -d -p 8080:80 -p ft_server"
echo "https://localhost"

bash