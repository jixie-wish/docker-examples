#!/bin/bash

docker compose build --no-cache

docker compose up --no-start
docker compose start mongodb-0
sleep 20
docker compose start mongodb-1
sleep 20
docker compose start mongodb-2
sleep 20

echo "starting ycsb..."
docker compose start ycsb
