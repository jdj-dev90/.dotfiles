# Issue tracker: GitLab

Issues for `lab/dotfiles` live as GitLab issues. Use the [`glab`](https://gitlab.com/gitlab-org/cli) CLI for all operations.

## Conventions

- **Create an issue**: `glab issue create --title "..." --description "..."`.
- **Read an issue**: `glab issue view <number> --comments`. Use `-F json` for machine-readable output.
- **List issues**: `glab issue list -F json` with appropriate `--label` filters.
- **Comment on an issue**: `glab issue note <number> --message "..."`.
- **Apply / remove labels**: `glab issue update <number> --label "..."` / `--unlabel "..."`.
- **Close**: post the explanation with `glab issue note`, then `glab issue close <number>`.
- **Merge requests**: `glab mr create`, `glab mr view`, `glab mr note`.
- **API**: the project in `glab api` URLs is `lab%2Fdotfiles`.

Inside a harness sandbox `origin` is the host's mirror, so pass `-R lab/dotfiles` (the delivery loop is told it as `repo=`).

## Who writes

- **Host sessions** (the owner's own `glab` login) create, label, comment on and close issues.
- **Harness tasks** only read issues. They never change the Ticket; the merge request's `Closes #N` closes it on merge.
