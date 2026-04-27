# ISSUES

Issues JSON is provided at start of context. Parse it to get open issues with their bodies and comments.

You've also been passed a file containing the last 10 commits (SHA, date, full message). Review these to understand what work has been done.

# TASK BREAKDOWN

Break down the issues into tasks. An issue may contain a single task (a small bugfix or visual tweak) or many, many tasks (a PRD or a large refactor).

Make each task the smallest possible unit of work. We don't want to outrun our headlights. Aim for one small change per task.

# TASK SELECTION

Pick the next task. Prioritize tasks in this order:

1. Critical bugfixes
2. Tracer bullets for new features

Tracer bullets comes from the Pragmatic Programmer. When building systems, you want to write code that gets you feedback as quickly as possible. Tracer bullets are small slices of functionality that go through all layers of the system, allowing you to test and validate your approach early. This helps in identifying potential issues and ensures that the overall architecture is sound before investing significant time in development.

TL;DR - build a tiny, end-to-end slice of the feature first, then expand it out.

3. Polish and quick wins
4. Refactors

If all tasks are complete, output <promise>COMPLETE</promise>.

# EXPLORATION

Explore the repo and fill your context window with relevant information that will allow you to complete the task.

# EXECUTION

Complete the task.

If you find that the task is larger than you expected (for instance, requires a refactor first), output "HANG ON A SECOND".

Then, find a way to break it into a smaller chunk and only do that chunk (i.e. complete the smaller refactor).

# FEEDBACK LOOPS

Before committing, run the feedback loops:

- `pnpm run test` to run the tests
- `pnpm run lint` to run the linting
- `pnpm run typecheck` to run the type checker

# COMMIT

Make a git commit. The commit message must:

1. Start with `RALPH:` prefix
2. Include task completed + PRD reference
3. Key decisions made
4. Files changed
5. Blockers or notes for next iteration

Keep it concise.

# THE ISSUE

If the task is complete, close the original GitHub issue.

If the task is not complete, leave a comment on the GitHub issue with what was done.

When including feedback loop results (`test`, `lint`, `typecheck`) in issue comments, never paste full raw logs. Always post a concise summary.

## COMMENT SAFETY

Prevent shell interpolation artifacts in issue comments:

- Treat comment text as literal markdown, not shell code.
- Never build comment bodies with `echo "..."`, command substitution, or unescaped double-quoted strings.
- When using `gh issue comment`, prefer `--body-file` with a temporary markdown file.
- If using a heredoc, always use a single-quoted delimiter (`<<'EOF'`) so `$VAR`, backticks, and `$(...)` are not expanded.
- Before posting, quickly verify the final comment text does not contain accidental escaped fragments, broken `$` variables, or command output placeholders.

## BLACKLIST

Don't work on these issues for whatever reason:

1. <https://github.com/Akron-Realty-LTD/akron-realty/issues/51>
2. <https://github.com/Akron-Realty-LTD/akron-realty/issues/49>
3. <https://github.com/Akron-Realty-LTD/akron-realty/issues/48>

# FINAL RULES

ONLY WORK ON A SINGLE TASK.
