#!/bin/bash

TARGET_DIR="/app"
TEMP_DIR="/tmp/app-temp"

if [ -f "$TARGET_DIR/.env" ]; then
    echo ".env file exists, not overwriting."
else
    cp $TEMP_DIR/.env $TARGET_DIR/
fi

rsync -a --exclude '.env' $TEMP_DIR/ $TARGET_DIR/

chown -R www-data:www-data $TARGET_DIR

exec supervisord
