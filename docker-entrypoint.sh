#!/bin/bash

TARGET_DIR="/app"
TEMP_DIR="/tmp/app-temp"

if [ -f "$TARGET_DIR/.env" ]; then
    echo ".env file exists, not overwriting."
else
    cp $TEMP_DIR/.env $TARGET_DIR/
fi

if [ -f "$TARGET_DIR/.env.example" ]; then
    echo ".env.example file exists, not overwriting."
else
    cp $TEMP_DIR/.env.example $TARGET_DIR/
fi

cp -r $TEMP_DIR/* $TARGET_DIR/

chmod -R 777 $TARGET_DIR

php artisan queue:work >/tmp/work.log 2>&1 &
exec supervisord
