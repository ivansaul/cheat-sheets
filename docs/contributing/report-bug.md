---
title: Bug Reports
icon: lucide/bug
---

# Bug Reports

Submitting accurate bug reports ensures maintainers can quickly identify and fix issues.

!!! warning "Check the Issue Tracker"
    Always search the [GitHub Issues] page before creating a new report. If an issue already exists for your bug, simply leave a comment or reaction to confirm it.
    
  [GitHub Issues]: https://github.com/ivansaul/cheat-sheets/issues

## Creating a Report

Head over to our [New Issue] page. A good bug report presents maintainers with a clear path to reproduce the problem.

Provide a descriptive title for your issue and include the following details in the body:

### Description

Explain the bug succinctly. Provide context regarding what the application was doing before the crash or unexpected layout occurred.

```markdown
## Description
The application crashes when tapping the "Change Language" 
button directly after completing a download.
```

### Steps to Reproduce

The most critical element of the report. List the exact sequence of actions needed to trigger the bug.

```markdown
## Steps to Reproduce
1. Open the application.
2. Navigate to 'Settings'.
3. Tap on 'Change Language'.
4. Note the app closes instantly.
```

### Expected Behavior

Contrast the expected outcome against the actual outcome.

```markdown
## Expected Behavior
A dialog prompt listing available languages should appear.

## Actual Behavior
The application closes immediately (crashes).
```

### Environment

Bugs often rely on specific hardware or architectures. Append your environment details.

```markdown
## Environment
- **Device:** iPhone 13 Pro
- **OS:** iOS 16.4
- **Version:** 0.4.0+9
```

  [New Issue]: https://github.com/ivansaul/cheat-sheets/issues/new

!!! tip "Visual Evidence"
    If the issue refers to a visual glitch or layout anomaly, drag-and-drop screenshots or a short video clip directly into the GitHub text editor. Pictures drastically reduce diagnosis time.
