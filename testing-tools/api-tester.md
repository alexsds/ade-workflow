# API Endpoint Testing

## Applies To

Features with REST APIs, GraphQL endpoints, WebSocket handlers, or any server-side endpoints that return data.

## Setup

No special setup required. Uses curl, httpie, or the app's built-in test client via Bash.

## How To Use

1. Ensure the API server is running
2. Test each endpoint defined in the feature:
   - Send requests with valid data and verify correct responses
   - Send requests with invalid data and verify error handling
   - Test authentication/authorization if applicable
   - Check response status codes, headers, and body structure
3. Test edge cases:
   - Empty request bodies
   - Missing required fields
   - Invalid field types
   - Extremely long strings
   - Special characters in inputs

## Example Test Commands

```bash
# Test a GET endpoint
curl -s http://localhost:3000/api/tasks | jq .

# Test a POST endpoint with valid data
curl -s -X POST http://localhost:3000/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"title": "Test task", "description": "A test"}' | jq .

# Test validation (missing required field)
curl -s -X POST http://localhost:3000/api/tasks \
  -H "Content-Type: application/json" \
  -d '{"description": "Missing title"}' | jq .

# Test not found
curl -s http://localhost:3000/api/tasks/nonexistent | jq .
```

## What To Check

- Correct HTTP status codes (200, 201, 400, 401, 403, 404, 500)
- Consistent response envelope structure
- Proper error messages for invalid inputs
- Data persistence (POST then GET should return the created resource)
- List pagination works correctly
- Authentication rejects unauthorized requests
- No sensitive data leaked in responses (passwords, tokens, internal IDs)
