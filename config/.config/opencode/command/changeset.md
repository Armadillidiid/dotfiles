---
description: Generate a Changeset entry
subtask: true
---

Create a changeset describing the user facing impact of the code changes made.

The changeset file should be structured as follows and created at the root of the project under the `.changeset/` directory:

```md
---
"<package-name>": <bump-type>
---

<description of the user facing change>
```

Example:

```md
---
"@heartbeat/web": minor
---

Redesign admin home page with new data visualizations and removed legacy drag-and-drop.
```

Guidelines to adhere to:

- Explain WHY the change matters from an end-user perspective, not just WHAT changed.
- Be specific. Avoid generic statements like “improved UX” or “updated API.”
- Describe the actual user-visible behavior change, bug fix, or new capability.
- If multiple packages are impacted, include each package and its bump type in the frontmatter.
- The description should be max one sentence.
