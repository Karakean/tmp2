#!/bin/bash

DB_NAME="dlugierozdzkidb"
DB_USER="dlugierozdzki"
DB_PASSWORD="password"
DB_ROOT_PASSWORD="root"
DB_ROOT_LOGIN="root"
DUMP_FILE="./dbinit/dlugierozdzkidb.sql"

docker exec -it be_184865_db mysql -p$DB_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
docker exec -it be_184865_db mysql -p$DB_ROOT_PASSWORD -e "CREATE USER IF NOT EXISTS ${DB_USER}@'%' IDENTIFIED BY '${DB_PASSWORD}';"
docker exec -it be_184865_db mysql -p$DB_ROOT_PASSWORD  -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
docker exec -it be_184865_db mysql -p$DB_ROOT_PASSWORD  -e "FLUSH PRIVILEGES;"
docker exec -i be_184865_db mysql -p$DB_ROOT_PASSWORD $DB_NAME < $DUMP_FILE
