---
description: Git commit
subtask: true
model: github-copilot/gpt-5-mini
---

Commit using the Conventional Commits specification.

The commit message should be structured as follows:

```
<type>[optional scope]: <description>
```

Prefer to explain why you made the change from an end-user perspective, not just what changed. Don't use generic messages like "improved agent experience" — be specific about user-facing effects.

If your changes touch multiple domains (for example: UI, API, database), create separate commits per domain so each commit stays atomic and easy to review.

Don't add body or footer text.
