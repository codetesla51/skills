# Skill Index — start here

Map of every skill in this repo. Match the task to a branch, then load ONLY the skill(s) needed. Never load all of them.

```
                        ~/.agents/skills/
                               |
        +----------+-----------+-----------+-----------+-----------+
        |          |           |           |           |           |
      GO/.       DEBUG     WORKFLOW      STYLE        UI        NOTES
      BACKEND    & QUALITY               & DOCS               & OPS
        |          |           |           |           |           |
  go-develop-  debug-    git-work-   coding-     design      obsidian-
   ment*        ging      flow        style*       *          markdown
  go-quirks-   code-     plan-       readme-     daisyui     obsidian-
   and-safety   explainer  mode       writing     frontend-   cli
  go-codebase- barrage   architec-               design      obsidian-
   cleanup     explainer  ture-                   landing-    bases
  go-preship-            planning                page        json-
   check       (how to    code-                   ui-         canvas
  api-library-  explain)  ownership               planning-   knap
   design                tutor                   scaffold-   defuddle
                                                 ing         azure-
                                                 ui-ux-      deploy-
                                                 pro-max     ment
                                                 quickshell-
                                                 modules

  * = router: points at other skills, load only what the task needs
```

## Trigger → skill

| When the task is... | Load |
|---|---|
| Any Go work | `go-development/` (router — picks sub-skills) |
| Writing/editing Go: maps, slices, pointers, goroutines, channels, resources | `go-quirks-and-safety/` |
| Simplifying AI-written Go | `go-codebase-cleanup/` |
| Pre-ship audit, PR review, "is this safe to ship" | `go-preship-check/` |
| Designing a Go library API | `api-library-design/` |
| A bug to find and fix | `debugging/` |
| Explain a repo / teach a codebase | `code-explainer/` |
| Explain anything to Uthman | `explainer/` |
| App is slow, find the bottleneck | `barrage/` |
| Commit, PR, release, tag, CI, `gh` CLI | `git-workflow/` |
| Plan before coding | `plan-mode/` |
| Plan software architecture | `architecture-planning/` |
| Keep Uthman owning AI-written code | `code-ownership/` |
| Teach a topic in depth | `tutor/` |
| Write Go code at all | `coding-style/` (always alongside Go work) |
| Write a README | `readme-writing/` |
| Any UI/design work | `design/` (router — picks sub-skills) |
| HTML/JSX + Tailwind | `daisyui/` (mandatory for HTML/JSX) |
| Distinctive visual design, not defaults | `frontend-design/` |
| Landing page | `landing-page/` |
| Scaffold a UI first | `ui-planning-and-scaffolding/` |
| UI/UX review or fix | `ui-ux-pro-max/` |
| Quickshell bar modules in ~/dotfiles | `quickshell-modules/` |
| Obsidian notes, wikilinks, callouts | `obsidian-markdown/` |
| Operate on the vault from CLI | `obsidian-cli/` |
| Obsidian Bases (.base) | `obsidian-bases/` |
| Canvas files (.canvas) | `json-canvas/` |
| Templates → Markdown notes (Knap) | `knap/` |
| HTML → clean Markdown (Defuddle) | `defuddle/` |
| Deploy Go on Azure VMs | `azure-deployment/` |

Each skill lives at `<name>/SKILL.md` relative to this file.
