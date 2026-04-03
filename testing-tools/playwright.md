# Playwright Browser Testing

## Applies To

Features with UI, web pages, user interactions, visual elements, forms, navigation, or any browser-rendered content.

## Setup

MCP server configuration (inline in evaluator agent):

```yaml
mcpServers:
  - playwright:
      type: stdio
      command: npx
      args: ["-y", "@playwright/mcp@latest"]
```

If Playwright MCP is not available, fall back to running the app and using Bash to curl endpoints or check DOM output.

## How To Use

1. Ensure the app is running (check for dev server process or start it)
2. Navigate to the running app URL (typically http://localhost:3000 or similar)
3. Interact with the feature as a real user would:
   - Click buttons, fill forms, navigate between pages
   - Test the complete user flow described in the plan's user stories
4. Take screenshots for visual verification when evaluating design quality
5. Check responsive behavior at common breakpoints (mobile: 375px, tablet: 768px, desktop: 1280px)

## What To Check

- All interactive elements respond to clicks/input
- Navigation flows work end-to-end without dead ends
- Forms validate inline and submit correctly
- Error states display properly with informative messages
- Loading states appear during async operations
- Visual design matches the coherence expected by the frontend-design rubric
- No console errors during normal usage
- Page loads complete within reasonable time (< 3 seconds)
