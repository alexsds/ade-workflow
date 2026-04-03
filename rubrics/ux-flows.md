# UX Flows Rubric

## Applies To

Features involving user journeys, multi-step workflows, onboarding sequences, form flows, or any feature where the user moves through multiple states or screens.

## Criteria

### Flow Coherence (weight: high)

Threshold: 7/10

The user journey should feel natural and logical. Each step should clearly lead to the next. The user should never wonder "what do I do now?" or "how did I get here?"

Evaluate: Is the happy path obvious? Are transitions between steps smooth? Is the current position in the flow always clear? Can users go back without losing progress?

### Edge Case Handling (weight: high)

Threshold: 7/10

The flow should handle real-world scenarios: empty states, error states, partial completion, timeouts, and unexpected user behavior. Users should never hit a dead end.

Evaluate: What happens when the user submits an empty form? What if a network request fails mid-flow? Can the user recover from errors without restarting? Are loading states shown during async operations?

### Information Architecture (weight: medium)

Threshold: 6/10

Information should be presented at the right time in the right amount. Users should not be overwhelmed with options or starved of context. Progressive disclosure should guide complexity.

Evaluate: Is the most important information prominent? Are secondary actions clearly subordinate? Is the amount of information per step manageable? Does the flow avoid unnecessary steps?

### Feedback & Confirmation (weight: medium)

Threshold: 6/10

Users should receive clear feedback for every action. Destructive actions should require confirmation. Success states should be celebratory. Error states should be informative and recoverable.

Evaluate: Does every button click produce visible feedback? Are destructive actions confirmed? Do success messages confirm what happened? Can users undo recent actions?

## Scoring Guide

- 9-10: Exceptional — intuitive flow, handles all edge cases gracefully
- 7-8: Solid — clear path, good error handling, no dead ends
- 5-6: Acceptable — works for happy path but rough on edge cases
- 3-4: Below standards — confusing flow, dead ends, poor error recovery
- 1-2: Failing — broken flow, users get stuck, no error handling
