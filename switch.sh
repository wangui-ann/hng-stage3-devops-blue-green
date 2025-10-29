#!/bin/bash

ENV_FILE=".env"
CURRENT=$(grep ACTIVE_POOL "$ENV_FILE" | cut -d '=' -f2)

if [ "$CURRENT" = "blue" ]; then
  NEW="green"
else
  NEW="blue"
fi

# Update .env
sed -i "s/ACTIVE_POOL=$CURRENT/ACTIVE_POOL=$NEW/" "$ENV_FILE"
echo "Switched to $NEW"

docker-compose --env-file "$ENV_FILE" up -d --build nginx

docker-compose --env-file "$ENV_FILE" up -d --build

