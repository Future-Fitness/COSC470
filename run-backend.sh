#!/bin/bash

echo "Starting Backend on port 5008..."
echo "================================"

cd backend

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
  echo "Installing backend dependencies..."
  pnpm install
fi

# Load environment variables from .env
export $(cat .env | grep -v '^#' | xargs)

echo "Backend will run on http://localhost:${PORT}"
echo ""

# Run the backend
pnpm start
