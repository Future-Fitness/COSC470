#!/bin/bash

echo "======================================"
echo "Running Application Locally (No Docker)"
echo "======================================"
echo ""
echo "Prerequisites:"
echo "  - Node.js and pnpm installed"
echo "  - MariaDB/MySQL running on port 33123"
echo "  - Database 'cosc471' created"
echo ""
echo "Services will run on:"
echo "  - Backend:  http://localhost:5008"
echo "  - Frontend: http://localhost:5009"
echo ""
echo "======================================"
echo ""

# Make scripts executable
chmod +x run-backend.sh
chmod +x run-frontend.sh

# Function to cleanup on exit
cleanup() {
  echo ""
  echo "Shutting down services..."
  kill $BACKEND_PID $FRONTEND_PID 2>/dev/null
  exit 0
}

trap cleanup SIGINT SIGTERM

# Start backend in background
echo "Starting backend..."
./run-backend.sh &
BACKEND_PID=$!

# Wait a bit for backend to start
sleep 3

# Start frontend in background
echo "Starting frontend..."
./run-frontend.sh &
FRONTEND_PID=$!

echo ""
echo "======================================"
echo "Services are running!"
echo "Press Ctrl+C to stop all services"
echo "======================================"
echo ""

# Wait for both processes
wait $BACKEND_PID $FRONTEND_PID
