#!/bin/bash

echo "Stopping Docker containers..."
docker-compose down

echo "Rebuilding and starting containers..."
docker-compose up --build -d

echo "Waiting for services to be ready..."
sleep 5

echo "Checking container status..."
docker-compose ps

echo ""
echo "Services are starting up!"
echo "Frontend: http://localhost:3000"
echo "Backend: http://localhost:5000"
echo ""
echo "To view logs, run: docker-compose logs -f"
