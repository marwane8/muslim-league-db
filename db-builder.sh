#!/bin/bash

# Generating a Local Test Database 
rm -rf ./databases/*.db  #delete old databases

echo "BUILDING bball.db..."
cat ./bball-db/bball-schemas.sql | sqlite3 ./databases/bball.db
cat ./bball-db/bball-views.sql | sqlite3 ./databases/bball.db
cat ./bball-db/insert-data.sql| sqlite3 ./databases/bball.db

echo "BUILDING soccer.db..."
cat ./soccer-db/soccer-schemas.sql | sqlite3 ./databases/soccer.db
cat ./soccer-db/soccer-views.sql | sqlite3 ./databases/soccer.db
cat ./soccer-db/insert-data.sql| sqlite3 ./databases/soccer.db

echo "BUILDING users.db..."
cat ./users-db/users-schemas.sql | sqlite3 ./databases/users.db
cat ./users-db/users-test-data.sql | sqlite3 ./databases/users.db
