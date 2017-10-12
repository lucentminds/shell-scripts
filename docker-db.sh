#!/bin/bash

# 10-11-2017
# spin up a mariadb instance.
# ~~ Scott Johnson

docker kill my-mariadb
docker container rm my-mariadb
docker container prune
docker run -d -p 3306:3306 -p 5567:5567 -p 5444:5444 -p 5568:5568 --name my-mariadb -e MYSQL_ROOT_PASSWORD=my_random_password mariadb:latest
docker ps
