
apt-get update
apt-get install -y nginx
apt-get install -y php
apt-get install -y php-cli php-fpm php-cgi
apt-get install -y php-mysql
apt-get install -y php-mbstring

apt-get purge -y apache2

#mysql
#service mysql start
#mysql < start.sql
#mysql wordpress -u root --password=  < wordpress.sql

#ssl
apt-get install -y openssl
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=MA/ST=rhamna/L=Bengruir/O=1337/CN=localhost' -keyout ./root/localhost.key -out ./root/localhost.crt

#wordpress
cp latest.tar.gz /var/www
rm -f latest.tar.gz
cd /var/www
tar -xf latest.tar.gz
rm -f latest.tar.gz


ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/
chown -R www-data:www-data /var/www/*
chmod -R 755 /var/www/*

/etc/init.d/php7.3-fpm start
service nginx start
