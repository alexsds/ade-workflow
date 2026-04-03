# Plan Examples

## Large Scope — Full Application

```yaml
---
project: Task Management App
date: 2026-04-03
scope: large
ticket: DEV-42
status: draft
---
```

### Goal

A collaborative task management application that helps small teams organize work, track progress, and meet deadlines. The app combines intuitive task boards with AI-powered features that automatically suggest priorities and detect blockers.

### Phase 1: Core Task Management

**Feature 1.1: Task Board**
- As a user, I want to see all my tasks on a visual board so that I can quickly understand what needs attention
- As a user, I want to drag tasks between columns so that I can update their status effortlessly
- As a user, I want to filter tasks by assignee, due date, or label so that I can focus on what matters

**Feature 1.2: Task Creation & Editing**
- As a user, I want to create tasks with a title, description, and due date so that work is clearly defined
- As a user, I want to assign tasks to team members so that responsibility is clear
- As a user, I want to add labels and priorities so that I can categorize and triage work

### Phase 2: Collaboration

**Feature 2.1: Real-time Updates**
- As a team member, I want to see changes from others in real time so that I always have current information
- As a user, I want to receive notifications when tasks assigned to me are updated

**Feature 2.2: Comments & Activity**
- As a user, I want to comment on tasks so that I can discuss work in context
- As a user, I want to see an activity feed showing recent changes across the project

### Phase 3: AI Features

**Feature 3.1: Smart Prioritization**
- As a user, I want AI to suggest task priorities based on due dates, dependencies, and team workload
- As a manager, I want AI to flag potential blockers before they become critical

### Success Criteria

- Users can create, organize, and track tasks across a visual board
- Real-time collaboration works across multiple simultaneous users
- AI features provide actionable suggestions that users find helpful
- The app handles 50+ concurrent users without performance degradation

---

## Medium Scope — Feature

```yaml
---
project: Notification System
date: 2026-04-03
scope: medium
status: draft
---
```

### Goal

Add a real-time notification system to the existing app so users know when things that matter to them change — task assignments, comments, status updates, and approaching deadlines.

### Deliverables

**In-app notifications**
- As a user, I want to see a notification bell with unread count so I know when something needs attention
- As a user, I want to click a notification to go directly to the relevant item
- As a user, I want to mark notifications as read individually or all at once

**Notification preferences**
- As a user, I want to control which events trigger notifications so I'm not overwhelmed
- As a user, I want to mute notifications for specific projects or time periods

**Email digest (optional)**
- As a user, I want a daily email summary of unread notifications so I don't miss important updates

### Acceptance Criteria

- Notifications appear within 2 seconds of the triggering event
- Users can customize notification preferences per event type
- Notification bell shows accurate unread count
- Clicking a notification navigates to the correct item
- No duplicate notifications for the same event

---

## Small Scope — Task / Bug Fix

```yaml
---
project: Fix empty form submission crash
date: 2026-04-03
scope: small
status: draft
---
```

### Goal

Fix the login page crash when submitting an empty form. The app throws an unhandled TypeError because the validation function assumes email is always a string.

### What to change

The form submission handler in the login component calls `email.trim()` without checking if email is defined. When the form is submitted empty, email is `undefined` and `.trim()` throws. Add input validation before processing.

### Done when

- Submitting an empty login form shows a validation error instead of crashing
- Submitting with only email (no password) shows appropriate error
- Existing login flow still works correctly with valid credentials
