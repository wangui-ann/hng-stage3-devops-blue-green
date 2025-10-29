#!/bin/bash

ENV_FILE=".env"

# Read current pool
CURRENT=$(grep ACTIVE_POOL "$ENV_FILE" | cut -d '=' -f2)

# Toggle
if [ "$CURRENT" = "blue" ]; then
  NEW="green"
else
  NEW="blue"
fi

# Replace in .env
sed -i "s/ACTIVE_POOL=$CURRENT/ACTIVE_POOL=$NEW/" "$ENV_FILE"

echo "Switched to $NEW"

# Restart stack
docker-compose --env-file "$ENV_FILE" up -d --build

