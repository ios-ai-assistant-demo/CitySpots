---
name: uikit-to-swiftui
description: Incrementally migrate UIKit screens, view controllers, views, table or collection interfaces to SwiftUI while preserving behavior, navigation, dependencies, analytics, accessibility, localization, and rollout compatibility. Use for UIViewController, UIView, UITableView, UICollectionView, storyboard, nib, UIHostingController, or representable migration tasks.
---

# UIKit to SwiftUI

Migrate one user-visible slice at a time. Preserve product behavior first; improve architecture only where the migration requires it.

## Establish the boundary

- Read repository instructions and inspect the entry point, callers, child views, state, actions, navigation, dependencies, analytics, localization, accessibility, and loading, empty, error, and content states.
- Trace storyboards, nibs, delegates, notifications, data sources, routers, and lifecycle side effects.
- Record a short parity ledger: observable behavior, UIKit source, SwiftUI destination, and verification method.
- Keep services, models, and unrelated architecture unchanged unless a small adapter is required.

## Choose the smallest safe integration

- Use a native SwiftUI entry point when the surrounding feature is already SwiftUI.
- Use UIHostingController when an existing UIKit router or navigation stack must present the new screen.
- Use UIViewRepresentable or UIViewControllerRepresentable only when there is no practical SwiftUI replacement.
- Keep the UIKit implementation until every caller is migrated and the new route is verified. Delete it only for an explicitly requested full replacement with no remaining references.

## Preserve behavior

- Give mutable state one owner and follow the repository's Observation or ObservableObject conventions.
- Pass dependencies explicitly; do not construct hidden globals inside the view.
- Preserve navigation, dismissal, selection, pagination, keyboard, focus, alerts, sheets, deep links, and analytics.
- Map lifecycle work to task, onAppear, or onDisappear only when repetition and cancellation match UIKit behavior.
- Preserve stable identity in lists and grids.
- Preserve safe areas, Dynamic Type, VoiceOver, localization, contrast, and reduced motion.
- Keep UI state updates on the main actor and cancel screen-bound work when appropriate.

## Verify

- Build the affected scheme and run existing relevant tests. Do not add or modify tests unless explicitly requested.
- Exercise the real navigation path on the configured simulator when available.
- Check loading, content, empty, error, interaction, and dismissal states.
- Compare the result with the parity ledger and available screenshots.
- Search for remaining callers and storyboard or nib references before deleting UIKit code.
- Report changed files, preserved behavior, remaining bridge code, performed verification, and unproven risks.

Do not combine the migration with an unrelated architecture rewrite or silently drop analytics, accessibility, localization, reuse behavior, or error states.

Example: Перепиши ProfileViewController на SwiftUI. Сохрани поведение и внешний вид.
