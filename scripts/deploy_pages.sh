#!/usr/bin/env bash
set -euo pipefail

if [ -z "${GITHUB_TOKEN:-}" ]; then
  echo "missing GITHUB_TOKEN"
  exit 1
fi
if [ -z "${GITHUB_REPOSITORY:-}" ]; then
  echo "missing GITHUB_REPOSITORY"
  exit 1
fi

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
APP_ROOT="$ROOT/app/app_root"
BUILD_DIR="$APP_ROOT/build/web"
COVERAGE_FILE="$APP_ROOT/coverage/lcov.info"
DEPLOY_DIR="$ROOT/.gh-pages"

pushd "$APP_ROOT" >/dev/null
flutter test --coverage
flutter build web --release
popd >/dev/null

rm -rf "$DEPLOY_DIR"
mkdir -p "$DEPLOY_DIR"
cp -r "$BUILD_DIR/"* "$DEPLOY_DIR/"
if [ -f "$COVERAGE_FILE" ]; then
  mkdir -p "$DEPLOY_DIR/coverage"
  cp "$COVERAGE_FILE" "$DEPLOY_DIR/coverage/lcov.info"
fi

pushd "$DEPLOY_DIR" >/dev/null
rm -rf .git
git init
git checkout -B gh-pages
GIT_AUTHOR_NAME="${GITHUB_ACTOR:-github-actions[bot]}"
GIT_AUTHOR_EMAIL="${GITHUB_ACTOR:-github-actions[bot]}@users.noreply.github.com"
git config user.name "$GIT_AUTHOR_NAME"
git config user.email "$GIT_AUTHOR_EMAIL"
git add -A
COMMIT_MSG="ci: deploy web build ${GITHUB_SHA:-local}"
git commit -m "$COMMIT_MSG"
REPO_URL="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git push --force "$REPO_URL" gh-pages
popd >/dev/null
