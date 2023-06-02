#!/bin/bash

# SCRIPT TO BUILD DATABASES LOCALLY
rm -rf ./databases/*.db  #clear old databases

echo "BUILDING bball.db..."
cat ./bball-db/bball-schemas.sql | sqlite3 ./databases/bball.db
cat ./bball-db/bball-views.sql | sqlite3 ./databases/bball.db
cat ./bball-db/insert-data.sql| sqlite3 ./databases/bball.db

echo "BUILDING users.db..."
cat ./users-db/users-schemas.sql | sqlite3 ./databases/users.db
cat ./users-db/users-test-data.sql | sqlite3 ./databases/users.db
