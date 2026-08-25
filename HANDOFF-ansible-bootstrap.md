# Handoff: Ansible bootstrap for personal + work Arch laptops (round 2)

## What this is

Round 1 (previous session, sandboxed, only `.dotfiles` mounted) designed an Ansible bootstrap
from scratch and wrote it up in a plan file, without knowing a real prior attempt already
existed. Round 2 (this session) discovered that prior attempt — `~/code/playbooks/workstation-setup`
on Jordan's real machine — pushed it to `jdj-dev90/ansible`, read it in full, and ran a `grill-me`
session to reconcile the two designs. **The old plan file's flat `tasks/` design is superseded —
do not use it.** The existing role-based repo is the foundation going forward.

This session ran entirely in a sandbox with no Arch/pacman/yay access, so several fixes were
designed but never applied to actual files, and a few items need real-machine data before they
can be finalized. Jordan is starting a fresh Claude Code conversation **outside the sandbox, on
the real machine**, specifically so it can read real `pacman`/`yay` state directly — pick up
execution there.

## Where the repo lives

- GitHub: `jdj-dev90/ansible`, content under a `workstation-setup/` subdirectory (not repo root).
- Real machine path: `~/code/playbooks/workstation-setup` (already a git repo, already pushed —
  confirmed via `gh api repos/jdj-dev90/ansible/git/trees/HEAD` returning real content, not empty).
- Layout: `ansible/roles/{base,dev,ssh_key,dotfiles,shell,lang,cloud,pass,gui}`, plus
  `archinstall/` (manual install guide), `bootstrap/arch-bootstrap.sh` (pre-Ansible: installs
  git/python/ansible/stow/docker/yay), `scripts/{lint,test}.sh` + `Makefile`, `README.md`,
  `RUNBOOK.md`.

## Decisions locked in this session (do not re-litigate)

1. **Generalize to both machines now**, not later. Both laptops should end up in near-identical
   states via one playbook.
2. **Hostnames**: work = `jordan-work`, personal = `jordan-personal`. Timezone
   (`Australia/Brisbane`) and locale (`en_AU.UTF-8`) are **identical** on both — only `hostname`
   (and derived branching) actually differs. Recommended mechanism (not yet implemented): move
   host-specific vars into a per-host file (e.g. `vars/<hostname>.yml`) included from
   `playbook.yml` via `ansible_hostname`, rather than growing `when:` conditionals inline.
3. **`wallpapers` stow package**: include on **both** machines (not personal-only, contra the
   original plan file). Jordan wants potentially different wallpaper images per machine
   eventually, but `wallpapers/` in `.dotfiles` today is a single flat stow package with one
   image (`wallpapers/.wallpapers/synth_blue_palm.jpg`) — no split exists yet. Splitting wallpaper
   *content* per machine is a **`.dotfiles`-repo change** (e.g. separate `wallpapers-personal` /
   `wallpapers-work` stow packages), out of scope for the ansible repo itself. Jordan said dotfiles
   can be updated as needed to support this — treat as a small separate follow-up, not a blocker.
4. **`cloud` role is work-only** (`google-cloud-sdk`/`gcloud`) — personal laptop doesn't need it.
5. **SSH/GPG automation stays as-is** — this was a real fork with the old plan file (which said
   "no key material automation at all"). Confirmed decision: keep the existing `ssh_key` role
   (generates a **new** ed25519 keypair per machine, pauses for manual GitHub upload) and the
   existing `pass` role (imports a **pre-exported** GPG private key from `~/Downloads/secret.gpg`,
   clones `pwd-store`, asserts fingerprint match). `pass`/`password-store` is confirmed still
   actively used. Per-machine SSH keys (not a shared reused key) is intentional and fine.
6. **Repo layout stays role-based** — the old plan file's flat `tasks/` design is dropped entirely
   in favor of the existing `roles/` structure, since real work already exists there.
7. **AUR packages: per-role, not centralized.** Each role that needs AUR packages should own its
   own `aur_packages` list (e.g. `cloud` owns `google-cloud-sdk`-equivalent if it were AUR — see
   item 9 below, it turned out not to be). No `aur_packages` mechanism exists yet at all; needs
   building: a reusable task (e.g. `roles/aur_packages/tasks/main.yml` or a shared included task
   file) running `yay -S --needed --noconfirm {{ aur_packages }}` with **`become: false`** (never
   run yay as root).
8. **`dotfiles` role's `STOW_FOLDERS` is stale — fix to match reality.** Current (wrong) value:
   `bin,gitconfig,nvim,screenlayout,tmux,wallpapers,x11,zsh`. Correct value, confirmed directly
   from the real, current `zsh/.zsh_profile` on this machine:
   `bin,nvim,tmux,zsh,wayland,ghostty,gitconfig,wallpapers,ssh` (drops deleted `x11`/`screenlayout`,
   adds `wayland`/`ghostty`/`ssh`).
9. **`gui` role needs a full rewrite of its package list**, confirmed via real `pacman -Qqe` /
   `yay -Qqem` output from the personal laptop:
   - **Drop**: `stalonetray` (X11 systray, dead weight under Waybar which has its own tray module).
   - **Keep**: `zathura`, `pavucontrol`.
   - **Add** (all confirmed **official-repo pacman packages, NOT AUR** — none appeared in the
     `yay -Qqem` AUR list): `hyprland`, `hyprshot`, `swaync`, `waybar`, `wl-clipboard`, `wofi`,
     `xdg-desktop-portal`, `xdg-desktop-portal-gtk`, `xdg-desktop-portal-hyprland`.
   - So **no `aur_packages` entry needed for `gui`** — everything above is plain `package:`.
10. **systemd `--user` service enablement**: add a task (after the `dotfiles` role, since it needs
    the stowed unit files in place first) to enable+start `waybar.service`, `swaync.service`,
    `audio-defaults.service` — real unit files already exist at
    `wayland/.config/systemd/user/{waybar,swaync,audio-defaults}.service` in `.dotfiles`. Use
    `scope: user`, `become: false`.
11. **`cloud` role's `google-cloud-sdk` task is currently broken and needs replacing, not fixing
    in place.** Discovered on the work laptop: `gcloud` is **not** a pacman or AUR package at all
    — `yay -Qqem | grep -i google` returned nothing, and `which gcloud` resolved to
    `/home/jordan/google-cloud-sdk/bin/gcloud`, i.e. Google's own manually-installed standalone
    SDK archive extracted straight into the home directory. `.zshrc` already sources
    `~/google-cloud-sdk/path.zsh.inc` and (deferred) `completion.zsh.inc` — so path/completion
    should **not** be re-touched by the installer. Recommended replacement (proposed, not yet
    confirmed by Jordan): `ansible.builtin.unarchive` to pull Google's official
    `google-cloud-cli-linux-x86_64.tar.gz` release into `{{ user_home }}`, guarded with
    `creates: "{{ user_home }}/google-cloud-sdk"`, then run its bundled `install.sh
    --usage-reporting=false --command-completion=false --path-update=false`. **Confirm this
    approach with Jordan before implementing** — alternative would be switching to an AUR
    `google-cloud-cli` package if one actually works well, but that wasn't checked.

## Open items — resolve these on the real machine before/while implementing

1. **Confirm the `cloud` role replacement mechanism** (item 11 above) — get Jordan's sign-off on
   unarchive+install.sh vs. an AUR alternative.
2. **Package-list completeness decision (was blocking in the old plan file, now has real data but
   still needs a decision):** real `yay -Qqem` from the personal laptop surfaced tools not in any
   role yet: `postman-bin`, `bruno-bin`, `ngrok`, `cloudflare-warp-bin`, `slack-desktop`,
   `zsa-keymapp-bin`, `displaylink`, `neovim-nightly-bin`, `neofetch`, `ncpamixer`, `pacmixer`,
   `jqp`, `dockd`, `docker-sbx`. **Ask Jordan**: fold these into appropriate roles now (rough
   fit: `dev` → `neovim-nightly-bin`, `jqp`, `docker-sbx`/`dockd`; `shell` → `ncpamixer`,
   `pacmixer`, `neofetch`; new/other role → `slack-desktop`, `postman-bin`, `bruno-bin`,
   `cloudflare-warp-bin`, `ngrok`, `displaylink`, `zsa-keymapp-bin`), or leave roles minimal/curated
   as-is and treat this as a later pass. This was left unanswered when the session ended.
3. **Get real `pacman -Qqe` output** (not just the Hyprland-filtered grep already captured) if
   Jordan decides to expand `base`/`dev`/`shell`/`lang` roles for fuller parity — not yet obtained.
4. **`.dotfiles` wallpapers split** (item 3 above) — small separate follow-up if/when Jordan wants
   different wallpaper images per machine; not part of the ansible repo itself.
5. Actually implement all of the above in `ansible/roles/*` — none of items 2–11 in the locked
   decisions list have been written to files yet. This entire session was reconciliation/design
   only, per the `grill-me` skill's scope (no file edits during grilling).

## Redaction note

No secrets, tokens, or private key material were exposed or handled in this session. The GPG
fingerprint (`5EDF4EFC982097211EFA22820E3D38ACB02C5925`) and SSH key comment
(`jdj.dev90@gmail.com`) appearing in `playbook.yml` are not secrets themselves (a fingerprint is
a public identifier; the comment is just a label) but are worth being mindful of given the repo
is public — nothing to redact, just noting for awareness.
