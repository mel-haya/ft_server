FROM debian:buster

COPY srcs/services.sh .
COPY srcs/localhost /etc/nginx/sites-available/
COPY srcs/start.sql .
COPY srcs/wordpress.sql .
COPY srcs/latest.tar.gz /var/www/
COPY srcs/mysql-apt-config_0.8.15-1_all.deb .

CMD bash services.sh && tail -f /dev/null
