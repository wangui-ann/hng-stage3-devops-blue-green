#!/bin/bash
ENV_FILE=".env"
CURRENT=$(grep ACTIVE_POOL "$ENV_FILE" | cut -d '=' -f2)
NEW=$([ "$CURRENT" = "blue" ] && echo "green" || echo "blue")
sed -i "s/ACTIVE_POOL=$CURRENT/ACTIVE_POOL=$NEW/" "$ENV_FILE"

cp ./nginx/nginx.$NEW.conf ./nginx/nginx.conf

docker exec $(docker ps -qf "name=nginx") nginx -s reload

echo "Switched to $NEW"
