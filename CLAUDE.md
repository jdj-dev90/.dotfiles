@AGENTS.md

## Checks

Run before every commit (CI runs the same):

- `grep -lE '^#!(/bin/sh|/bin/bash|/usr/bin/env (ba)?sh)' bin/.local/scripts/* | xargs shellcheck -S warning` (CI enforces errors only until the existing warnings are fixed)
- `grep -lE '^#!/usr/bin/env python3' bin/.local/scripts/* | xargs -n1 python3 -m py_compile`

Most changes can only be verified in the owner's live session (Hyprland, waybar, tmux, nvim, mail). List those under Unverified in the merge request instead of claiming them.

## Hard rules

- No secret values anywhere: not in code, logs or commits. Scripts read secrets from `pass` by name.
- No attribution lines in commits or merge requests.
- `docs/`, `CLAUDE.md`, `AGENTS.md` and `.gitlab-ci.yml` are repo metadata, not Stow packages; never add them to `STOW_FOLDERS`.

## Agent skills

### Issue tracker

Issues live in this project's GitLab issues, used with `glab`. See `docs/agents/issue-tracker.md`.

### Triage labels

See `docs/agents/triage-labels.md`.
