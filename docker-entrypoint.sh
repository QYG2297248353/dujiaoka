#!/bin/bash

TARGET_DIR="/app"
TEMP_DIR="/tmp/app-temp"

if [ ! -f "$TARGET_DIR/.env" ]; then
    cp $TEMP_DIR/.env $TARGET_DIR/
fi

rsync -av --exclude '.env' $TEMP_DIR/ $TARGET_DIR/

chown -R www-data:www-data $TARGET_DIR

php artisan queue:work >/tmp/work.log 2>&1 &
exec supervisord
