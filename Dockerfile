FROM webdevops/php-nginx:7.4

WORKDIR /app

COPY . /tmp/app-temp/

RUN apt-get update && apt-get install -y rsync \
    && composer install --ignore-platform-reqs --working-dir=/tmp/app-temp

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN chmod -R 777 /tmp/app-temp

EXPOSE 80
EXPOSE 9000

CMD ["/usr/local/bin/docker-entrypoint.sh"]
