---
description: Fetch Copilot PR review suggestions and create a plan to address them
agent: plan
subtask: true
---

Fetch the Copilot (or any bot) review comments on a GitHub PR and create a plan to address them.

**Input**: $ARGUMENTS — either a PR number (e.g. `21`) or a full PR URL (e.g. `https://github.com/owner/repo/pull/21`).

## Step 1 — Parse the input

Extract the PR number and the `owner/repo` from `$ARGUMENTS`. If the input is a bare number, infer `owner/repo` from `git remote get-url origin`. Resolve to a numeric PR id.

## Step 2 — Fetch the review comments

Use `gh api --jq` — no external dependency, handles multi-line body strings correctly.

```bash
gh api "repos/${OWNER}/${REPO}/pulls/${PR}/comments?per_page=100" \
  --jq '.[] | "### \(.path):\(.line) (id=\(.id))\n\n\(.body)\n---"'
```

Also fetch the PR summary:

```bash
gh api "repos/${OWNER}/${REPO}/pulls/${PR}" \
  --jq '"PR #\(.number): \(.title)\nhead: \(.head.sha)\nbase: \(.base.ref)"'
```

## Step 3 — Read the source at each comment's line

For every comment, read the cited file at the cited line range. Group comments by file. Verify each claim against the actual code — Copilot sometimes flags intent-vs-reality gaps, sometimes flags real bugs. Don't take a comment at face value; check.

For the patches that the comments propose, use the explore agent (read-only) to:
- confirm the file:line exists
- read the surrounding context (~20 lines before and after)
- identify any related code (callers, tests, related types) that would need to change together
- surface any contradiction with the PR's stated design

## Step 4 — Group and prioritise

Sort the comments by severity:

- **P0 (critical correctness)**: silent data loss, broken invariants, or features that don't work. Examples: exception grouping bug, reminders only fire once, exception chain never applies.
- **P1 (correctness)**: edge cases that produce wrong but not catastrophic results. Examples: window overlap, year parameter ignored, gating missing on a write path.
- **P2 (cleanup)**: doc mismatches, test bugs that pass for the wrong reason, refactors that tighten the contract.

Reject comments that are wrong or that conflict with intentional design. If a comment suggests something the team has already considered and rejected (see `.opencode/plans/*.md` for prior plans), say so in the plan and skip it.

## Step 5 — Ask clarifying questions

Before writing the plan, ask the user via the `question` tool about anything that isn't obvious from the code:

- For P0 fixes: ship in this PR or a follow-up?
- For gating decisions (reject with 400 vs. fall back gracefully): which behaviour does the team want?
- For doc mismatches: fix the doc or fix the code?
- For test refactors: minimal fix or restructure?

Group the questions by theme; ask at most 3 questions in a single round.

## Step 6 — Write the plan

Write the final plan to the standard plan file at `.opencode/plans/${TIMESTAMP}-<slug>.md` (use the current epoch ms as the timestamp and a 2-3 word slug of the user's intent). The plan should include:

1. A summary table of every Copilot comment with severity, file:line, and a one-line summary.
2. The user's decisions from Step 5, restated.
3. A "Touch points" section with the specific code changes for each accepted comment — copy-pasteable, not vague.
4. A "Verification" section: how to test each fix (typecheck, e2e, manual smoke).
5. An "Out of scope" section for anything rejected or deferred.

## Step 7 — Exit

Call `plan_exit` to surface the plan for approval. Do not implement anything — the user will switch to build mode after they approve.

## Anti-patterns

- Do not blindly accept every Copilot suggestion. Some are noise or wrong. Verify by reading the code.
- Do not write the plan without first reading the cited files. "Looks plausible" is not verification.
- Do not include vague "consider this" or "we might want to" items in the plan. Every item should have a concrete touch point (file:line) and a concrete change.
- Do not propose changes that contradict a prior plan in `.opencode/plans/` without flagging the conflict to the user.
