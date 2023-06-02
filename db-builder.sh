#!/bin/bash

# SCRIPT TO BUILD DATABASES LOCALLY

echo "BUILDING bball.db..."
cat ./bball-db/bball-schemas.sql | sqlite3 bball.db
cat ./bball-db/bball-views.sql | sqlite3 bball.db
cat ./bball-db/bball-test-data.sql | sqlite3 bball.db
