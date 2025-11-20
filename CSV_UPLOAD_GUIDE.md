# CSV Student Upload Feature

## Overview
This feature allows teachers to bulk upload students to a class using CSV files. Students are automatically created if they don't exist, and enrolled in the specified course.

## How to Use

### 1. Prepare Your CSV File
Create a CSV file with the following format:

```csv
email,name,id,password
john.doe@example.com,John Doe,10001,password123
jane.smith@example.com,Jane Smith,10002,password123
bob.johnson@example.com,Bob Johnson,10003
```

#### CSV Columns:
- **email** (required) - Student's email address (used as unique identifier)
- **name** (optional) - Student's full name (defaults to email prefix if not provided)
- **id** (optional) - Student ID number (auto-generated if not provided)
- **password** (optional) - Initial password (defaults to `letmein` or `DEFAULT_STUDENT_PASSWORD` env var)

### 2. Upload the CSV
1. Navigate to the **Class Members** page
2. Click the **"Upload CSV"** button (green button with upload icon)
3. Click or drag-and-drop your CSV file
4. Review the file details
5. Click **"Upload Students"**

### 3. Review Results
The upload result will show:
- **Added**: New students successfully enrolled
- **Already Enrolled**: Students who were already in the class
- **Errors**: Any students that failed to process (with error details)

## Features

### Smart User Creation
- If a student email already exists in the system:
  - Existing student is enrolled in the class
  - Teacher accounts cannot be added as students (error shown)
- If a student email doesn't exist:
  - New student account is created automatically
  - Password is set to default or provided value

### Duplicate Handling
- Students already enrolled in the class are skipped (no error)
- Shows count of already enrolled students for transparency

### Error Handling
- Invalid email addresses are rejected
- Missing required fields are caught
- Teacher accounts cannot be added as students
- Individual row errors don't stop the entire upload
- Detailed error messages for debugging

## API Endpoint

### POST `/upload_students_csv`
Multipart form upload endpoint

**Request:**
```
Content-Type: multipart/form-data

Fields:
- file: CSV file (required)
- courseId: Number (required)
```

**Response:**
```json
{
  "message": "Successfully processed 5 student(s)",
  "addedCount": 3,
  "alreadyEnrolledCount": 1,
  "errorCount": 1,
  "results": {
    "added": ["john.doe@example.com", "jane.smith@example.com"],
    "alreadyEnrolled": ["bob.johnson@example.com"],
    "errors": [
      {
        "email": "invalid@example.com",
        "error": "User is a teacher and cannot be added as student"
      }
    ]
  }
}
```

## File Structure

### Backend
- `backend/src/routes/upload_students_csv.ts` - Upload endpoint handler
- `backend/src/util/csv.ts` - CSV parsing utility

### Frontend
- `frontend/src/components/StudentCSVUpload.tsx` - Upload modal component
- `frontend/src/pages/ClassMembers.tsx` - Integration point

## Environment Variables

```bash
DEFAULT_STUDENT_PASSWORD=letmein  # Default password for new students
```

## Sample CSV File
A sample CSV file is available at: `sample-students.csv`

## Technical Details

### CSV Parsing
- Uses existing `csv2json` utility function
- Handles empty lines gracefully
- Trims whitespace from values
- Validates required fields

### Database Operations
- Uses `findOrCreate` for users (idempotent)
- Uses `findOrCreate` for enrollments (prevents duplicates)
- Wrapped in try-catch for individual row error handling
- No transactions (partial success is acceptable)

### Security
- Teacher authentication required (auth middleware)
- Course ownership validated
- Teacher accounts protected from student enrollment
- Passwords are hashed with SHA-512

## Limitations
- Max file size: 100MB (configurable in backend)
- No batch operation limit (processes all rows)
- CSV format must have headers in first row
- Comma-separated only (no tab or other delimiters)

## Future Enhancements
- [ ] Support for bulk student updates (not just creation)
- [ ] CSV template download
- [ ] Preview before upload
- [ ] Batch operation progress indicator
- [ ] Export enrolled students to CSV
- [ ] Support for additional student fields (major, year, etc.)
