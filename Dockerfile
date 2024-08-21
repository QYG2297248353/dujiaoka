FROM webdevops/php-nginx:7.4

WORKDIR /app

COPY . /tmp/app-temp/

RUN chmod -R 777 /tmp/app-temp

RUN composer install --ignore-platform-reqs --working-dir=/tmp/app-temp

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 80
EXPOSE 9000

VOLUME ["/app"]

CMD ["/usr/local/bin/docker-entrypoint.sh"]
