# Test Credentials

## Available Test Users

### Student Accounts
- **Username:** `test`
  **Password:** `1234`
  Email: test@test.com

- **Username:** `alice`
  **Password:** `password`
  Email: alice@example.com

### Teacher Accounts
- **Username:** `test2`
  **Password:** `1234`
  Email: test2@test.com

- **Username:** `professor`
  **Password:** `password`
  Email: prof@example.com

## Quick Start

1. Make sure Docker containers are running:
   ```bash
   docker-compose ps
   ```

2. If containers are not running, use the restart script:
   ```bash
   ./restart.sh
   ```

3. Open your browser and go to: http://localhost:3000

4. Login with any of the credentials above

5. You should see the dashboard with available courses

## Services

- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:5000
- **Database:** MariaDB on port 33123

## Common Commands

```bash
# Restart all services with fresh build
./restart.sh

# View logs
docker-compose logs -f

# View specific service logs
docker-compose logs -f backend
docker-compose logs -f frontend

# Stop all containers
docker-compose down

# Start without rebuilding
docker-compose up -d
```

## Features

After logging in, you can:
- View enrolled courses (students see courses they're enrolled in)
- Create new courses (teachers only)
- View course assignments
- Manage groups
- Create and view rubrics
- Submit peer evaluations
