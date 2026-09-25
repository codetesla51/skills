---
name: "git-workflow"
description: "How to commit, use GitHub via gh CLI, and set up CI/release pipelines."
version: 3
created: "2026-09-07"
updated: "2026-09-25"
---
# Git Workflow

## Commit conventions

Always use conventional commit format:

```
type(scope): short imperative subject

Optional body explaining WHY, not what (the diff already shows what).
```

**Subject rules (all mandatory):**
- Imperative mood: `fix:`, not `fixed:` or `fixes:`
- Lowercase first word after the colon, no trailing period
- Max ~72 characters — if it doesn't fit, the subject is doing the body's job
- Say what changed and why it matters: `fix: correct off-by-one in keyframe lookup` beats both `fix bug` (vague) and a paragraph (belongs in the body)

**Types:** `feat` (new feature), `fix` (bugfix), `refactor`, `perf`, `docs`, `test`, `chore`, `build`, `ci`, `revert`.
**Scope** is optional but required in multi-package repos — `fix(interpolator): ...` beats bare `fix: ...` when several areas exist. Omit it in single-purpose repos rather than inventing noise.

**Body** (blank line, then text) when the "why" needs more than the subject allows. Wrap at ~72 cols. Reference issues as `Closes #123` on its own line.

Good vs bad:
- `feat: add chaos fault injection` (good)
- `fix(proxy): drop packet_loss, upstream v2.12.0 lacks it` (good — why included)
- `update stuff` / `fix bug` / `feat: Added A New Feature.` (bad — vague, wrong mood, caps+period)

## Commit individually — one logical change per commit

Never batch unrelated work into one commit because it happened in the same session. A bugfix + a refactor + a feature = three commits. Each commit must be revertable on its own without dragging unrelated changes.

Procedure every time:
1. `git status --short` and `git diff --stat` — see everything that's dirty.
2. Group changed files/hunks by logical change.
3. Stage and commit each group separately with its own conventional message. Use `git add -p` when one file holds multiple unrelated hunks.
4. Verify with `git log --oneline -5` and `git show --stat HEAD` before moving to the next group.

Formatting-only churn (gofmt, import order) goes in its own `chore:` commit, never mixed into a `feat:`/`fix:`.

## GitHub via gh CLI — including the hard stuff

gh CLI is authenticated — use it directly instead of describing web-UI steps. Don't ask "should I use gh?" when the answer is obviously yes.

Everyday:
- `gh pr create --title "..." --body "..."`, `gh pr view`, `gh pr diff`, `gh pr checks`, `gh pr merge --squash --delete-branch`
- `gh issue list`, `gh issue view`, `gh issue create --title "..." --body "..."`
- `gh run list`, `gh run view`, `gh run watch <id>`, `gh workflow run <name>`
- `gh repo view`, `gh repo clone`, `gh search code|repos|issues`

Releases and tags:
- `gh release create v1.2.0 --title "v1.2.0" --notes "..." dist/*` (creates the tag too if missing)
- `gh release upload v1.2.0 dist/* --clobber` to attach assets later
- `gh release view v1.2.0`, `gh release list`

When a `gh` command fails, read the full error before retrying — most failures are wrong repo context (`-R owner/repo` fixes it), missing scope, or an existing tag/release name collision.

## Tagging convention (semver)

Tags look like `vMAJOR.MINOR.PATCH` — `v1.2.0`, never `1.2.0` or `release-1.2.0`.

- **PATCH** (`v1.2.0` → `v1.2.1`): bugfixes only, no API/behavior change.
- **MINOR** (`v1.2.1` → `v1.3.0`): new backwards-compatible features.
- **MAJOR** (`v1.3.0` → `v2.0.0`): breaking changes. Call this out in the commit body as `BREAKING CHANGE: ...`.
- Pre-releases while stabilizing: `v2.0.0-rc.1`, `v2.0.0-rc.2`, then final `v2.0.0`.

Rules:
- Always annotated tags with a message: `git tag -a v1.2.0 -m "Short summary of what's in it"`. Never lightweight tags for releases — annotating records tagger, date, and message.
- Tag only on main after CI is green on that exact commit. Tagging a red commit ships broken binaries.
- Push the tag explicitly: `git push origin v1.2.0` (plain `git push` doesn't send tags unless configured to).
- Mistagged? Delete both ends and redo: `git tag -d v1.2.0 && git push origin :refs/tags/v1.2.0`, then tag the right commit. Never move a tag silently after CI already built from it.
- The tag push is what triggers the release workflow (see below) — pushing the commit alone does not cut a release.

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
- Don't batch unrelated changes into one commit, and don't mix formatting churn into feature/fix commits.
- Don't tag a commit that hasn't passed CI, and don't retag silently after a release build already ran.
