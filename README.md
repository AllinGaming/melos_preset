## Melos preset
[![Coverage](https://img.shields.io/badge/coverage-98%25-brightgreen)](app/app_root/coverage/lcov.info)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Analysis](https://img.shields.io/badge/analysis-flutter%20analyze-blue)](https://github.com/allingaming/melos_preset/actions/workflows/ci.yml)
[![Code Quality](https://img.shields.io/badge/code%20quality-lints%20%2B%20tests-brightgreen)](https://github.com/allingaming/melos_preset/actions/workflows/ci.yml)
[![GitHub](https://img.shields.io/github/stars/allingaming/melos_preset?style=social)](https://github.com/allingaming/melos_preset)

Melos powered Flutter workspace that isolates an `app/app_root` application from reusable packages. The UI layer uses `go_router`, `flutter_bloc`/Cubits, and pushes a Retrofit/Dio/Freezed networking package through the `packages/networking` library so the workspace demonstrates Melos-style separation.

## Workspace overview
- `melos.yaml` wires the worktree together and exposes scripts (`melos exec -- flutter analyze` / `melos exec -- flutter test --coverage`).
- `app/app_root` contains the runnable Flutter app and its tests.
- `packages/networking` implements `ExampleFetcher` via Retrofit, Dio, Freezed.
- `packages/core` holds dependency injection (`get_it`) and a `TasksRepository` used by the app.

## Getting started
1. Install Flutter (and optionally `melos` via `dart pub global activate melos`).
2. Run `dart pub get` at the repository root to fetch Melos.
3. Run `dart run melos bootstrap` once to wire up dependencies across the workspace.
4. Use `cd app/app_root && flutter run` to start the example.

## Testing & coverage
- `cd app/app_root && flutter test --coverage` produces an `lcov.info` file in `app/app_root/coverage`.
- Coverage is currently **98.11%** (156/159 lines) according to that lcov output.
- To recompute the summary, run `python3 scripts/coverage_summary.py` and ensure `coverage/lcov.info` exists before committing.
- CI runs Flutter coverage with a 90% gate via `scripts/coverage_summary.py`, uploads `lcov.info`, generates a CycloneDX SBOM, and runs gitleaks for secret scanning.

## Governance & compliance
- `CODEOWNERS`, `SECURITY.md`, `COMPLIANCE.md`, and PR/issue templates are present; enable branch protection + required checks in GitHub.
- SBOM (`sbom.cdx.json`) is produced in CI; secret scanning runs via gitleaks.
- MIT licensed (LICENSE).

## CI & deployment
- `.github/workflows/ci.yml` runs on pushes/pull requests: it checks out the repo, sets up Flutter, runs `dart run melos bootstrap`, analyzes `melos exec -- flutter analyze`, and executes `flutter test --coverage` inside `app/app_root`, uploading the resulting `coverage/lcov.info` as an artifact.
- `.github/workflows/deploy.yml` triggers on `main` pushes, bootstraps the workspace, runs tests, builds the web app with a base href derived from the repo name (`/${repo}/`) for GitHub Pages, and publishes via `actions/deploy-pages`.

## Deployment script
`./scripts/deploy_pages.sh` performs:
1. `flutter test --coverage` and `flutter build web --release` inside `app/app_root`.
2. Copies the web artifacts plus `app/app_root/coverage/lcov.info` into a fresh `.gh-pages` directory.
3. Initializes a temporary Git repo, commits everything, and force-pushes to `gh-pages` using `GITHUB_TOKEN`/`GITHUB_REPOSITORY`.

Run the script locally with `GITHUB_TOKEN` set; GitHub Actions already exposes the token as a secret.

## Package highlights
- The Flutter app exposes `TasksCubit` (task list with toggle), `ThemeCubit`, and `NetworkCubit` (Retrofit fetch) built via DI (`get_it`).
- `GoRouter` drives navigation between the home and details pages, while `SectionCard` components keep UI consistent.
- `packages/networking` uses Retrofit + Dio to fetch `todos/1`, Freezed for the immutable response, and exposes an `ExampleFetcher` interface so the app can swap in test doubles when needed.
- `packages/core` owns `registerDependencies`/`resetDependencies`, the task domain (`Task`, `TasksRepository`), and wires `ExampleFetcher` for the UI layer.

## Scripts
| Task | Command |
| --- | --- |
| Bootstrap workspace | `dart run melos bootstrap` |
| Run analyzer | `melos exec -- flutter analyze` |
| Run app tests | `cd app/app_root && flutter test --coverage` |
| Coverage summary | `python3 scripts/coverage_summary.py` |
| Deploy to GitHub Pages | `scripts/deploy_pages.sh` (requires `GITHUB_TOKEN`) |
