---
description: Generate a Changeset entry
subtask: true
---

You are responsible for creating changeset entries that document user-facing impacts of code changes. Your job is to analyze what changed and communicate its value clearly.

---

Input: $1

---

## Determining What to Document

Based on the input provided, determine which changes to document:

1. **No arguments (default)**: Document all uncommitted changes
   - Run: `git diff` for unstaged changes
   - Run: `git diff --cached` for staged changes
   - Run: `git status --short` to identify untracked files

2. **Commit hash** (40-char SHA or short hash): Document that specific commit
   - Run: `git show branch`

3. **Branch name**: Document changes from current branch compared to the specified branch
   - Run: `git diff branch...HEAD`

4. **PR URL or number** (contains "github.com" or "pull" or looks like a PR number): Document the pull request changes
   - Run: `gh pr view branch` to get PR context
   - Run: `gh pr diff branch` to get the diff

Use best judgement when processing input.

---

## Gathering Context

**Diffs alone are not enough.** After identifying changes, read the full context of what was modified to understand the user-facing impact.

- Use the diff to identify which files and packages changed
- Read the full file to understand existing functionality and how the change affects it
- Check `package.json` to understand which package(s) are impacted and their current versions
- Look at existing changeset entries in `.changeset/` to match tone and style
- Check for CHANGELOG.md or similar documentation to understand versioning strategy

---

## What to Determine

**Semantic versioning bump** - Classify the change correctly.
- **patch**: Bug fixes, minor internal improvements with no user-visible change
- **minor**: New features, new capabilities, improved functionality
- **major**: Breaking changes, removed features, significant behavioral changes

**User-facing impact** - Explain what users will experience.
- What new capability is enabled?
- What bug is fixed and how does it help the user?
- What behavior changed and why does it matter?
- If internal-only or no user impact, document whether a changeset is needed

**Scope of impact** - Determine which packages are affected.
- Single package changes
- Multi-package changes (document each with its bump type)
- Monorepo vs single-package considerations

---

## Before You Create a Changeset

**Be certain about user impact.** 

- Only document changes that affect end users or their experience
- Internal refactoring without behavioral changes may not need a changeset
- Don't assume impact - verify by reading the actual changes and understanding the codebase
- If uncertain about the impact, investigate before deciding on the bump type

**Choose the correct bump type.**

- Don't over-classify: a small fix is a patch, not a minor
- Don't under-classify: a new feature is a minor, not a patch
- Breaking changes are major - be thorough in identifying what breaks
- Internal improvements without user-facing changes typically don't warrant a changeset

---

## Output Format

Changeset files are created at `.changeset/<descriptive-name>.md` and follow this structure:

```md
---
"<package-name>": <bump-type>
---

<description of the user-facing change>
```

**Rules:**

1. **Describe the WHY, not just the WHAT** - Explain why the change matters from an end-user perspective.
2. **Be specific** - Avoid generic statements like "improved UX" or "updated API." Name the actual behavior change.
3. **One sentence maximum** - Keep descriptions concise and focused.
4. **Multiple packages** - If multiple packages are impacted, include each with its bump type in the frontmatter.
5. **Tone** - Write clearly and directly. Focus on user impact, not implementation details.

---

## Example

Input: Changes that redesign the admin dashboard with new visualizations

```md
---
"@repo/web": minor
---

Admin home page now displays real-time performance metrics with interactive charts, replacing the static summary view.
```

Example with multiple packages:

```md
---
"@repo/web": minor
"@repo/api": patch
---

Admin dashboard displays performance metrics provided by updated API endpoint with improved data accuracy.
```
