---
name: github-branch-review
description: Perform a careful local review of a GitHub branch or pull request in an isolated worktree. Resolve the target, inspect the exact diff file by file, verify relevant behavior, and write actionable findings in Russian. Apply Apple-platform checks for Swift, Objective-C, Xcode, iOS, macOS, watchOS, or visionOS changes. Do not publish comments or reviews unless explicitly requested.
---

# GitHub Branch Review

Review changes locally as a second pass after implementation. Accept a branch name, issue, PR URL, PR number, or repository plus target.

## Resolve the target

1. Resolve PR or issue metadata and its head/base refs when provided.
2. For a branch, determine the correct base branch instead of assuming it.
3. Identify the intended behavior and any existing verification evidence.
4. Enable Apple-platform mode when the delta contains Swift, Objective-C, Xcode projects, Apple resources, or platform runtime behavior.

Ask for the repository only when the supplied input still does not identify a concrete target.

## Isolate the review

- Create one disposable git worktree as a sibling of the host workspace.
- Never reset, clean, or switch branches in the long-lived workspace.
- Keep the persistent review note outside the disposable worktree under review-notes/.
- Fetch the target ref first if it is not available locally.

Use the exact resolved delta:

    git diff <base>...HEAD

If that diff contains unrelated commits or misses expected changes, fix the base before reviewing.

## Review workflow

1. Record repository, target, base, worktree path, and expected behavior.
2. Create the review note immediately.
3. Read the diff file by file.
4. Read enough surrounding source to validate each potential finding.
5. Check correctness, edge cases, state flow, error handling, performance, regressions, and scope drift.
6. Keep only findings caused by the reviewed delta and requiring a real fix.
7. Verify build or runtime behavior when the changed behavior requires it.
8. Remove only the disposable worktree after the review; keep the note.

Do not change product code during a review-only task. Do not create branches, commits, pushes, PR comments, or GitHub reviews unless the user explicitly asks.

## Apple-platform checks

Check only areas relevant to the delta:

- SwiftUI and UIKit state ownership, Observation lifetimes, and duplicated sources of truth;
- actor isolation, MainActor use, Sendable, cancellation, and task lifetime;
- navigation, deep links, restoration, dismissal, and invalid routes;
- repeated lifecycle effects, retain cycles, notifications, streams, and cleanup;
- persistence migrations and backward compatibility;
- analytics exactly-once behavior and side effects triggered by rendering;
- availability guards, deployment targets, simulator versus device behavior;
- Dynamic Type, VoiceOver, localization, contrast, keyboard, safe areas, and size classes;
- assets, bundles, entitlements, privacy descriptions, and target membership;
- main-thread work, unnecessary view invalidation, image handling, and leak risks.

A successful build is compile evidence, not runtime proof. State exactly which target, scheme, destination, and runtime path were actually checked.

## Findings gate

Keep a finding only when:

- it is introduced by or directly follows from the reviewed change;
- the problem is concrete and reproducible or strongly evidenced;
- the impact matters beyond style preference;
- the proposed fix fits the surrounding code;
- it still holds after rereading the full source.

Each finding must include file path, problem, impact, current behavior, and a concrete fix. Add a compact before/after snippet when useful.

If no required fixes are found, say so explicitly in Russian. Mention the path to the review note in the final response.

## Example requests

- Use $github-branch-review to review branch feature/settings in acme/mobile-app.
- Use $github-branch-review to review issue #42 and the related branch.
- Use $github-branch-review to review PR #17 and write findings in Russian.
