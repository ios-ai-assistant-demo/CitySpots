---
name: ios-architecture-review
description: "Review the architecture of an iOS project, feature, or diff: SwiftUI and UIKit boundaries, state ownership, MVVM responsibilities, dependency injection, shared state, navigation, persistence, analytics, and coupling risks. Produce a short local report; do not publish a GitHub or Arc review."
---

# iOS Architecture Review

Produce a short architecture review that names the actual pattern, checks whether the change fits it, and identifies the highest-risk coupling or ownership problems.

## Inspect

Start from the touched files or the smallest relevant feature slice:

- app entry and dependency setup;
- navigation or feature construction;
- shared state, stores, services, and persistence ownership;
- feature views and UIKit controllers;
- view models or state owners;
- models, converters, analytics, and adapters used by the feature.

## Review checks

1. Identify the real architecture pattern. Do not force a label such as clean MVVM onto a mixed codebase.
2. Trace who owns and mutates state; verify that SwiftUI wrappers and UIKit lifetimes match that ownership.
3. Prefer explicit dependencies over hidden singletons when the type already has a dependency boundary.
4. Keep UI, state mapping, persistence, analytics, and navigation from collapsing into one view or controller.
5. Check module and feature boundaries for dependency cycles and app-target imports.
6. Check testability and previewability; hidden globals and side effects in views are risks.
7. Report only findings that matter for behavior or maintainability.

## Output

Use this compact structure:

    Architecture:
    Finding 1:
    Finding 2:
    Suggested fix:
    Proof to run:
    Limits:

Do not publish a review or create tickets, branches, commits, or PRs. Skip style-only preferences or mark them low priority.
