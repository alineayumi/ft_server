#!bin/bash

# Give nginx user-group rights over page files
chown -R www-data /var/www/*

# Change permissions for folders
chmod -R 755 /var/www/*

# Create server folder
mkdir /var/www/localhost

echo " ----------------- "
echo "| SETTING SSL KEY |"
echo " ----------------- "

mkdir /etc/nginx/ssl
openssl req -newkey rsa:4096 \
            -x509 \
            -sha256 \
            -days 3650 \
            -nodes \
            -out /etc/nginx/ssl/localhost.pem \
            -keyout /etc/nginx/ssl/localhost-key.pem \
			-subj "/C=US/ST=California/L=Fremont/O=42/OU=aline/CN=ft_server"

echo " --------------- "
echo "| SETTING NGINX |"
echo " --------------- "
mv /tmp/nginx.conf /etc/nginx/sites-available/localhost
mv /tmp/info.php /var/www/localhost/
mv /tmp/index.html var/www/localhost/
ln -s /etc/nginx/sites-available/localhost etc/nginx/sites-enabled/localhost
rm -rf /etc/nginx/sites-enabled/default

echo " --------------- "
echo "| SETTING MYSQL |"
echo " --------------- "
service mysql start
mysql -u root --skip-password <<EOF
CREATE DATABASE db;
GRANT ALL ON db.* TO 'root'@'localhost' IDENTIFIED BY 'mysupersecretpassword';
FLUSH PRIVILEGES;
EOF

echo " ------------- "
echo "| SETTING PHP |"
echo " ------------- "

# Restart nginx after settings
service php7.3-fpm start
service nginx restart

echo " -------------- "
echo "| NGINX STATUS |"
echo " -------------- "
nginx -t
service nginx status
echo ""

echo "[ LINKS & COMMANDS ]"
echo "docker build -t ft_server ."
echo "docker run --name ft_server -d -p 80:80 -p 443:443 ft_server"
echo "https://localhost"

bash