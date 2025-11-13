#!/bin/bash

echo "Starting Frontend on port 5009..."
echo "================================="

cd frontend

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
  echo "Installing frontend dependencies..."
  pnpm install
fi

echo "Frontend will run on http://localhost:5009"
echo ""

# Run the frontend
pnpm dev
