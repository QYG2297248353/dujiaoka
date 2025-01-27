FROM webdevops/php-nginx:7.4

WORKDIR /app

RUN apt-key adv --fetch-keys http://nginx.org/keys/nginx_signing.key \
    && apt-get update && apt-get install -y --no-install-recommends rsync \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY . /tmp/app-temp/

RUN chmod -R 777 /tmp/app-temp

RUN composer install --ignore-platform-reqs --working-dir=/tmp/app-temp

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 80
EXPOSE 9000

VOLUME ["/app"]

CMD ["/usr/local/bin/docker-entrypoint.sh"]
