
apt-get update
apt-get install -y nginx
apt-get install -y php
apt-get install -y php-cli php-fpm php-cgi
apt-get install -y php-mysql
apt-get install -y php-mbstring

apt-get purge -y apache2


#mysql
apt-get install -y gnupg
apt-get install -y lsb-release wget
export DEBIAN_FRONTEND=noninteractive
echo 'mysql-apt-config mysql-apt-config/select-server select mysql-5.7' | debconf-set-selections
dpkg -i mysql-apt-config_0.8.15-1_all.deb
apt-get update
apt-get install -y mysql-server
chown -R mysql: /var/lib/mysql
service mysql start

#init database

mysql -u root -e "CREATE DATABASE wordpress;";
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;";
mysql -u root -e "UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE user='root';";
mysql wordpress -u root --password=  < wordpress.sql

#ssl
apt-get install -y openssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=MA/ST=rhamna/L=Bengruir/O=1337/CN=localhost' -keyout ./root/localhost.key -out ./root/localhost.crt

#wordpress
cd /var/www
tar -xf latest.tar.gz
rm -f latest.tar.gz


ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

/etc/init.d/php7.3-fpm start
service nginx start
