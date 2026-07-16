---
name: feature-modularizer
description: Extract a bounded Swift or iOS feature into one self-contained local Swift Package with a small public entry point, explicit dependencies, and build proof. Use when asked to extract, split, modularize, isolate, or move a feature into a separate module without changing behavior.
---

# Feature Modularizer

Turn one bounded feature into a self-contained local Swift Package without changing its behavior.

Create one package with one library target. Keep the screen, state handling, and feature-specific helpers together; let the host app enter through a small public facade and supply external dependencies explicitly.

## Input

Infer from the request and repository:

- feature: the feature to extract;
- source path: its current directory, if present;
- package: normally <Feature>Feature.

If only a feature name is provided, locate its files and consumers. Ask only when inspection leaves two materially different module boundaries.

## Constraints

- Preserve UI, state transitions, navigation, persistence, analytics, accessibility, and localization.
- Create one local Swift Package with one library target, not speculative layers.
- Keep the public surface small: one entry point plus required input and dependency values.
- Keep views, view models, state, and feature-specific helpers internal.
- Do not read app-global singletons from the extracted module.
- Pass app-owned capabilities through a small dependency value, protocol, or closure.
- Keep shared models in their current owner unless moving them is required for a clean dependency direction.
- Follow existing build-system and module conventions. Do not hand-edit generated project files.
- Do not add or modify tests unless explicitly requested.
- Do not create branches, commits, pushes, reviews, or tickets.
- Use the repository's documented Xcode version, scheme, and simulator configuration.

## Completion contract

The task is complete only when:

1. The selected implementation lives in a local Swift Package with Package.swift and one library target.
2. The module has one obvious public way to construct or open the feature.
3. External state and services are passed explicitly.
4. Consumers do not construct feature-internal views or view models.
5. Original sources are not compiled twice.
6. The affected application scheme builds successfully.
7. Runtime behavior is smoke-checked or explicitly reported as unverified.

If a dependency cycle or ownership decision blocks extraction, stop after producing the dependency map and one recommended resolution.

## Workflow

### 1. Establish the baseline

1. Read AGENTS.md, CLAUDE.md, project manifests, and package manifests.
2. Detect the build system, existing module conventions, affected target, and scheme.
3. Record the working-tree state and preserve unrelated user changes.
4. Run the smallest relevant baseline build when practical.

If the baseline already fails, report the existing failure and continue only when the failure does not invalidate the migration.

### 2. Discover the boundary

Locate:

- feature views, controllers, view models, factories, state, and helpers;
- every external consumer;
- models owned outside the feature;
- app-global reads and writes;
- resources, previews, and target membership;
- navigation and feature construction.

Classify dependencies:

| Class | Meaning | Default action |
|---|---|---|
| inside | Used only by the feature | Move and keep internal |
| input | Small value needed to open the feature | Pass through the public entry point |
| dependency | App-owned state or service | Inject a protocol, value, or closure |
| shared | Used by multiple features | Keep in its lower-level owner |
| manual | Moving it creates a cycle or ownership change | Stop for one decision |

Before editing, print:

    Boundary: <feature>
    Move: <files>
    Entry point: <public facade>
    Inject: <app-owned dependencies>
    Consumers: <call sites>
    Risk: <none or one decision>

Proceed without another confirmation when the boundary is unambiguous.

### 3. Design the entry point

Prefer a small facade over exposing concrete screens or view models. Match the repository's navigation and dependency style.

If an app-owned model would make the module depend on the app target, pass a small identifier or input and inject the operation that loads the remaining data. Do not move a widely shared model merely to silence the compiler.

### 4. Scaffold one local package

- Follow a neighboring package as the template when one exists.
- Match its Swift tools version and platform settings.
- Declare one library product and one target.
- Put sources under Sources/<Feature>Feature/.
- Add only dependencies the feature uses.
- Move feature resources into the package resource bundle.
- Integrate the local package through the project's supported mechanism.
- Keep implementation types internal by default.

Build immediately after scaffolding so manifest errors stay separate from migration errors.

### 5. Move the vertical slice

1. Move feature-private views, state, and helpers.
2. Add only access control required by the facade and its small input and dependency types.
3. Replace global access with injected capabilities.
4. Construct the feature from host-app wiring.
5. Update callers to use the facade.
6. Remove old source membership and obsolete imports.

Build after the leaf group and after caller wiring. Fix errors by restoring dependency direction, not by making the whole module public.

### 6. Verify

Confirm that:

- callers use the public entry point;
- the package does not import the host app target;
- the feature does not read app-global singletons;
- no duplicate source membership remains;
- resources resolve from the module bundle;
- the affected scheme builds using the repository's required configuration.

Do not claim runtime proof unless the app was launched and the flow was exercised.

## Final response

Keep the response concise:

    Модуляризация завершена.

    - Проанализированы зависимости и внешние потребители <Feature>.
    - Создан самостоятельный модуль <Feature>Feature.
    - Экран, состояние и внутренние helpers перенесены внутрь модуля.
    - Снаружи оставлена одна точка входа.
    - Внешние сервисы подключены через явные зависимости.
    - Сборка <Scheme> прошла на <configuration>.
    - Runtime smoke-check: <result> | Runtime-поведение не проверялось.

    Результат: изолированная фича, явные зависимости и зелёная сборка.

For a blocked boundary, state the blocking dependency, the cycle or ownership problem, one recommended resolution, and whether code was changed.
