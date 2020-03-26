FROM debian:buster

COPY srcs/services.sh .
COPY srcs/localhost /etc/nginx/sites-available/
COPY srcs/start.sql .
COPY srcs/wordpress.sql .
COPY srcs/latest.tar.gz .

CMD bash services.sh && tail -f /dev/null
