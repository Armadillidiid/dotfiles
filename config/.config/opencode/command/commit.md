---
description: Git commit
subtask: true
---

Commit using the Conventional Commits specification.

The commit message should be structured as follows:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

Prefer to explain why you made the change from an end-user perspective, not just what changed. Don't use generic messages like "improved agent experience" — be specific about user-facing effects.

If your changes touch multiple domains (for example: UI, API, database), create separate commits per domain so each commit stays atomic and easy to review.

Add a body only when needed. If you do, keep it concise and prefer separate commits over a adding a body.
