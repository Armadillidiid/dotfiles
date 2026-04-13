---
description: Git commit
subtask: true
model: github-copilot/gpt-5-mini
---

Commit using the Conventional Commits specification.

The commit message/messages should be structured as follows:

```
<type>: <description>
```

- Don't use generic messages like "improved agent experience" — be specific about user-facing effects.
- Thrive to break up commits into small and focused changes to stay atomic and easy to review.
- Each commit should represent a single logical change or improvement.
- If you find yourself using the word "and" in your commit message, it's a sign you may want to split it into multiple commits.
- Don't add scope.
- Don't add body or footer text.

**NOTE**: Feel free to create multiple commits rather than trying to bundle everything into one.
