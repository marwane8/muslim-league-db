#!/bin/bash

# Generating a Local Test Database 
rm -rf ./databases/*.db  #delete old databases

echo "BUILDING database..."
echo "building schema"
cat ./dbsql/schemas.sql | sqlite3 ./databases/row.db
echo "building views"
cat ./dbsql/views.sql | sqlite3 ./databases/row.db
echo "inserting data"
cat ./dbsql/insert-data.sql| sqlite3 ./databases/row.db
