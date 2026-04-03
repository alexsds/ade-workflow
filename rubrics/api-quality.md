# API Quality Rubric

## Applies To

Features involving REST APIs, GraphQL endpoints, WebSocket handlers, or any server-side interface that clients consume.

## Criteria

### API Design (weight: high)

Threshold: 7/10

Endpoints should follow consistent naming conventions and HTTP semantics. Resource naming should be intuitive. URL structure should be predictable.

Evaluate: Are endpoints RESTful (or consistently following chosen paradigm)? Do HTTP methods match their semantics (GET reads, POST creates, etc.)? Is naming consistent across all endpoints? Are URL patterns predictable?

### Response Quality (weight: high)

Threshold: 7/10

Responses should be consistent in structure, include appropriate status codes, and provide useful error messages. Successful and error responses should follow the same envelope pattern.

Evaluate: Are status codes correct (201 for create, 404 for not found, etc.)? Is response structure consistent? Do error responses include actionable messages? Is pagination implemented for list endpoints?

### Input Validation (weight: medium)

Threshold: 6/10

All user inputs should be validated at the API boundary. Invalid inputs should return clear error messages indicating what is wrong and how to fix it.

Evaluate: Are required fields enforced? Are types validated? Are bounds checked (string length, number ranges)? Do validation errors specify which field failed and why?

### Security (weight: medium)

Threshold: 6/10

APIs should implement appropriate authentication and authorization. Sensitive data should not be exposed in responses. Rate limiting and input sanitization should be present where appropriate.

Evaluate: Is authentication required where expected? Are users authorized for the resources they access? Is sensitive data (passwords, tokens) excluded from responses? Are SQL injection and XSS vectors handled?

## Scoring Guide

- 9-10: Exceptional — clean, consistent, well-documented API
- 7-8: Solid — follows conventions, good error handling
- 5-6: Acceptable — works but inconsistent or missing edge cases
- 3-4: Below standards — inconsistent design, poor error handling
- 1-2: Failing — broken endpoints, security vulnerabilities, no validation
