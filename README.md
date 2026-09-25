# Canonical agent skills

`/home/uthman/.agents/skills` is the editable source of truth for personal, global skills on this machine.

The directory is a Git repository with this remote:

```text
https://github.com/codetesla51/skills.git
```

## What belongs here

- Personal skills that should be available across agents.
- Shared helper files, references, and data needed by those skills.
- Intentionally vendored third-party skills, with their source documented.

The `daisyui` directory was installed from [saadeghi/daisyui](https://github.com/saadeghi/daisyui). Keep third-party changes deliberate and review them before committing.

## What does not belong here

- Project-specific skills; those should stay with their project repository.
- Agent runtime state, conversations, credentials, or generated caches.
- Separate vendor repositories that are maintained independently.

## Agent compatibility

Pi and OpenCode discover `~/.agents/skills` automatically. An agent that requires a different global skills directory should use a symlink or configuration pointing here rather than maintaining another copy.

The old Pi path below is a legacy duplicate and must not be edited:

```text
~/.pi/agent/pi-hermes-memory/skills
```

## Edit and publish

```bash
cd ~/.agents/skills
git status
git add path/to/changed/files
git commit -m "feat(skills): describe the change"
git push origin main
```

Use focused conventional commits. Do not force-push `main`; review changes before publishing them.

To set up a fresh machine, clone the repository directly to the canonical path:

```bash
git clone https://github.com/codetesla51/skills.git ~/.agents/skills
```
