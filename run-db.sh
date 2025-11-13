#!/bin/bash

# Script to run MariaDB database in Docker with seeding

echo "Starting MariaDB database..."

# Stop any existing database container
docker-compose stop mariadb 2>/dev/null
docker-compose rm -f mariadb 2>/dev/null

# Start only the MariaDB service
docker-compose up -d mariadb

echo "Waiting for database to be ready..."

# Wait for the database to be ready (check every 2 seconds, max 30 seconds)
MAX_TRIES=15
TRIES=0

while [ $TRIES -lt $MAX_TRIES ]; do
    if docker-compose exec -T mariadb mysql -uroot -proot -e "SELECT 1;" &>/dev/null; then
        echo "Database is ready!"
        echo ""
        echo "Database connection details:"
        echo "  Host: localhost"
        echo "  Port: 33123"
        echo "  User: root"
        echo "  Password: root"
        echo "  Database: cosc471"
        echo ""
        echo "The database has been seeded with test data from schema.sql"
        echo ""
        echo "Test user credentials:"
        echo "  Email: test@test.com, Password: 1234"
        echo "  Email: test2@test.com, Password: 1234 (teacher)"
        echo "  Email: alice@example.com, Password: password123"
        echo "  Email: prof@example.com, Password: password123 (teacher)"
        exit 0
    fi
    TRIES=$((TRIES + 1))
    sleep 2
done

echo "Database failed to start within 30 seconds"
echo "Check logs with: docker-compose logs mariadb"
exit 1
