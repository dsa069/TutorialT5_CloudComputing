#!/bin/bash

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password my_password'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password my_password'
sudo apt update
sudo apt -y install mysql-server
wget https://gist.githubusercontent.com/ualmtorres/f8d0e5ea79a0e570f495087724288c6d/raw/0a894b23466bb6eea520a05559372e148e6e5803/sginit.sql -O /home/ubuntu/sginit.sql
mysql -h "localhost" -u "root" "-pmy_password" < "/home/ubuntu/sginit.sql"

sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sudo service mysql restart