#!/bin/bash

# Generating a Local Test Database 
rm -rf ./databases/*.db  #delete old databases

echo "BUILDING bball.db..."
echo "building schema"
cat ./bball-db/bball-schemas.sql | sqlite3 ./databases/bball.db
echo "building views"
cat ./bball-db/bball-views.sql | sqlite3 ./databases/bball.db
echo "inserting data"
cat ./bball-db/insert-data.sql| sqlite3 ./databases/bball.db

echo "BUILDING soccer.db..."
echo "building schema"
cat ./soccer-db/soccer-schemas.sql | sqlite3 ./databases/soccer.db
echo "building views"
cat ./soccer-db/soccer-views.sql | sqlite3 ./databases/soccer.db
echo "inserting data"
cat ./soccer-db/insert-data.sql| sqlite3 ./databases/soccer.db

echo "BUILDING users.db..."
cat ./users-db/users-schemas.sql | sqlite3 ./databases/users.db
cat ./users-db/users-test-data.sql | sqlite3 ./databases/users.db
