# AGENTS.md

This is a personal dotfiles repo managed with GNU Stow.

Use this file as a fast orientation map before editing configs.

## How it is applied

- Dotfiles are grouped as Stow packages (top-level folders like `zsh`, `nvim`, `tmux`, `wayland`).
- Install/relink entrypoint: `install`.
- `install` expects:
  - `DOTFILES` (typically `~/.dotfiles`)
  - `STOW_FOLDERS` (comma-separated package list)
- For each package, it runs `stow -D <package>` then `stow <package>`.

Current `STOW_FOLDERS` source of truth is in `zsh/.zsh_profile`.

## Repo layout

- `bin/.local/scripts/`: helper scripts used by shell/tmux/Wayland services.
- `zsh/`: shell setup (`.zshrc`, `.zsh_profile`), aliases, env, plugin bootstrapping.
- `nvim/.config/nvim/`: Neovim config (Lua modules + `lazy.nvim`).
- `tmux/.tmux.conf`: tmux config, TPM plugins, vim-aware navigation, clipboard behavior.
- `wayland/.config/`: Hyprland, waybar, wofi, swaync, and user systemd units.
- `ghostty/.config/ghostty/`: terminal config + Kanagawa theme.
- `cli/.config/`: Kanagawa themes for terminal tools (bat, btop, lazygit).
- `gitconfig/`: base git config and work-identity include templates.
- `wallpapers/.wallpapers/`: wallpaper assets.
- `screenshots/`: saved screenshots (data, usually not config).
- `firas.zahabi/`: personal media files (not runtime dotfiles).

## Session model (Hyprland only)

- Session launcher script: `bin/.local/scripts/start-session`.
- It now starts Hyprland directly.

### Hyprland monitor/workspace profile flow

- `wayland/.config/hypr/hyprland.conf` sources:
  - `~/.config/hypr/monitors.conf`
  - `~/.config/hypr/workspaces.conf`
- `bin/.local/scripts/hypr-monitor-profile`:
  - detects docked vs laptop using connected DRM outputs
  - repoints `monitors.conf` and `workspaces.conf` symlinks
  - triggers `hyprctl reload`
  - remaps workspaces to expected monitors
  - reshapes live tmux sessions via `tmux-layout-profile` to match the profile
- `bin/.local/scripts/hypr-monitor-watch` (exec-once) listens on Hyprland's
  socket2 for `monitoradded`/`monitorremoved` and re-runs `hypr-monitor-profile`
  after a 2s debounce, so docking/undocking mid-session switches profiles.

### tmux layout profiles

`tmux-sessionizer` builds one of two shapes per project session, chosen by the
same docked/laptop DRM check:

- docked: one `work` window, three side-by-side panes (term | nvim | agent)
- laptop: three windows (`1 editor`, `2 agent`, `3 term`)

Sessions keep the shape they were created with, so `bin/.local/scripts/tmux-layout-profile`
converts existing sessions between the two by moving panes (`break-pane` /
`join-pane`) rather than killing them. Bound to `prefix M-r` (auto),
`prefix M-d` (force panes), `prefix M-l` (force windows).

### Wayland user services

Defined in `wayland/.config/systemd/user/`:

- `waybar.service` -> `%h/.local/scripts/waybar-start`
- `swaync.service` -> `/usr/bin/swaync`
- `audio-defaults.service` -> `pactl` default sink/volume setup

## Shell behavior notes

- `.zshrc` bootstraps zinit + powerlevel10k and uses deferred init (`_zsh_defer`) for heavier integrations.
- `.zsh_profile` holds aliases and key env vars (`DOTFILES`, `SCRIPTS`, `STOW_FOLDERS`, `SECOND_BRAIN`, PATH additions).

## Neovim architecture

- Bootstrap: `nvim/.config/nvim/init.lua` (`lazy.nvim`).
- Core modules live in `nvim/.config/nvim/lua/config/*`.
- Plugin specs live in `nvim/.config/nvim/lua/plugins/*`.
- Project root helper: `nvim/.config/nvim/lua/config/project.lua`.

## tmux architecture

- TPM-managed plugin stack with Kanagawa themeing.
- Vim/tmux pane navigation interoperability (`C-h/j/k/l`, `C-\\`).
- Clipboard copy prefers Wayland (`wl-copy`) and falls back to `xclip`.
- Custom helpers include `tmux-sessionizer`, `tmux-splitter`, `tmux-windowizer`, `wt-pick` (worktree picker popup, prefix+w).
- `wt-dash` (Worktrunk dashboard TUI) lives in its own repo: `GOBIN=~/.local/bin go install github.com/jdj-dev90/wt-dash@latest`. `wt-pick` and the sessionizer's `.wt-dash` dashboard session call it.

## Git config behavior

- Base identity in `gitconfig/.gitconfig`.
- Conditional includes select work identities by repo path.
- GitHub/Gist credentials are provided via `gh auth git-credential`.

## Agent safety notes

1. Preserve Stow package boundaries and top-level structure.
2. Update `STOW_FOLDERS` when adding/removing packages.
3. Treat monitor names, audio sink IDs, and absolute paths as machine-specific.
4. Avoid committing personal data changes unless explicitly requested (`screenshots/`, `firas.zahabi/`).
5. Keep Kanagawa visual consistency unless the user requests a style change.

## Quick verification after edits

- Run `./install` after loading shell env.
- Validate shell startup (`zsh`), editor startup (`nvim`), and tmux startup (`tmux`).
- For display/session changes, validate in a real Hyprland session.
