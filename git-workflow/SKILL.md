---
name: "git-workflow"
description: "How to commit, use GitHub via gh CLI, and set up CI/release pipelines."
version: 2
created: "2026-09-07"
updated: "2026-09-07"
---
# Git Workflow

## Commit conventions

Always use conventional commit format: `type(scope): short description`

Common types: `feat`, `fix`, `refactor`, `docs`, `test`, `chore`, `perf`, `build`, `ci`.

- The description is short but genuinely helpful — say what changed and why it matters, not just what you feel like writing. "fix: correct off-by-one in keyframe lookup" beats both "fix bug" (too vague) and a full paragraph (too long for a subject line).
- Use the body (a blank line then more text) when the "why" needs more than the subject line allows — don't cram everything into the subject.
- Scope is optional but helpful in multi-package repos — `fix(interpolator): ...` beats a bare `fix: ...` when the repo has several distinct areas.

## Commit independently, not as one giant commit

Split unrelated changes into separate commits, even within the same task. If a task touches a bugfix and a refactor and a new feature, that's three commits, not one. Each commit should be a single coherent change that could, in principle, be reverted on its own without dragging unrelated changes with it.

Do not batch "fix bug + add feature + tidy formatting" into one commit just because they happened in the same session. Stage and commit each piece separately (`git add -p` when a single file has multiple unrelated hunks).

## GitHub via gh CLI

gh CLI is authenticated — use it directly whenever a GitHub action is needed, rather than describing steps for Uthman to do manually. This includes:

- Opening/reviewing PRs: `gh pr create`, `gh pr view`, `gh pr diff`
- Checking issues: `gh issue list`, `gh issue view`
- Checking CI status: `gh run list`, `gh run view`
- Creating releases: `gh release create`
- Checking repo state: `gh repo view`

Default to using the tool directly when the task calls for it — don't ask "should I use gh for this?" when the answer is obviously yes.

## CI / release pipeline convention

Uthman's standard workflow for a Go project: **build → test → CI passes → tag a release → CI compiles and attaches binaries per platform to that tagged release.**

When setting up CI/CD for a new project, structure it as:

1. **On every push/PR:** run `go build ./...` and `go test ./...` (plus `go vet` and lint, per the coding-style skill). This gate must pass before anything else happens.
2. **On a tagged release** (e.g. `v1.2.0` pushed as a git tag): a separate workflow triggers that:
   - Cross-compiles binaries for the relevant platforms (at minimum linux/amd64, linux/arm64, darwin/amd64, darwin/arm64 — adjust to what the project actually needs)
   - Attaches each compiled binary to the GitHub release via `gh release upload` or the release action's asset step

Use GitHub Actions for this unless the project already uses something else. A reasonable default shape:

```yaml
# .github/workflows/ci.yml — runs on every push/PR
name: CI
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-go@v5
      - run: go build ./...
      - run: go vet ./...
      - run: gofmt -l .
      - run: go test ./...
```

```yaml
# .github/workflows/release.yml — runs on tag push
name: Release
on:
  push:
    tags: ["v*"]
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-go@v5
      - run: |
          for os in linux darwin; do
            for arch in amd64 arm64; do
              GOOS=$os GOARCH=$arch go build -o dist/app-$os-$arch ./cmd/app
            done
          done
      - uses: softprops/action-gh-release@v2
        with:
          files: dist/*
```

Adjust build matrix, binary name, and entrypoint path (`./cmd/app`) to the actual project — this is the shape, not a literal template to paste unmodified.

## What to avoid

- Don't commit generated binaries, build artifacts, or `dist/` output to the repo — those belong in `.gitignore` and only get produced by CI on tag.
- Don't skip the CI gate step (build/test/vet/fmt) even for "small" changes — the pipeline exists so it runs the same way every time, not selectively.
- Don't manually walk Uthman through GitHub web UI steps when `gh` CLI can do the same thing directly — use the tool.