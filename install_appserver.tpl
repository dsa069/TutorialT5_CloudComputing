#!/bin/bash
echo "export MYSQL_SERVER=${mysql_ip}" >> /home/ubuntu/.profile

sudo apt-get update
sudo apt-get install -y apache2 php php-mysql libapache2-mod-php php-mcrypt
sudo chgrp -R www-data /var/www
sudo chmod -R 775 /var/www
sudo chmod -R g+s /var/www
sudo useradd -G www-data ubuntu
sudo chown -R ubuntu /var/www/

sudo rm /var/www/html/index.html
wget https://gist.githubusercontent.com/ualmtorres/1c833f9b471fa7351e2725731596f45e/raw/a66b26d90b5f75c3a37cfe12a2370b57d2768132/sginit.php -O /var/www/html/index.php

echo "export MYSQL_SERVER=${mysql_ip}" >> /etc/apache2/envvars
sudo service apache2 restart