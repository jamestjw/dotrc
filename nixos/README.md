# NixOS port of dotrc

A flake that reproduces the Fedora setup (`setup.sh` + `firewall.sh` + the
symlinked dotfiles) on NixOS.

## Layout

| File | Replaces |
|---|---|
| `configuration.nix` | `dnf install`-able system stuff: i3/X11, PipeWire, fonts, Tailscale + `firewall.sh`, Thunar |
| `home.nix` | `setup.sh` (package installs + dotfile symlinks), `bash/`, `git/.gitconfig`, `.tmux.conf` |
| `flake.nix` | pins nixpkgs 25.11 + home-manager |

Design choice: bash, git, and tmux are translated to native home-manager
modules (the old `.bashrc` was full of Fedora/macOS-specific shims that don't
apply on NixOS). Everything else (`nvim`, `i3`, `polybar`, `helix`, `ghostty`,
`kitty`, `rofi`, `mise`, `harper-ls`, `pantry`, scripts, …) is sourced from
this flake checkout. The repo can live anywhere, but config changes need a
rebuild before they appear in `~/.config`.

## Install

```bash
# 1. On the freshly installed NixOS machine:
git clone <this repo> ~/dotrc

# 2. Bring over the generated hardware config:
cp /etc/nixos/hardware-configuration.nix ~/dotrc/nixos/

# 3. Build (flakes only see git-tracked files — add new files first):
cd ~/dotrc
git add nixos/hardware-configuration.nix
sudo nixos-rebuild switch --flake ./nixos#jamestjw

# 4. One-time, post-install:
sudo tailscale up
rustup default stable
```

## Mapping notes / intentional differences

- **firewall.sh** → NixOS' firewall is default-deny inbound on every
  interface, which is what the firewalld `DROP` zone achieved. SSH (22/tcp)
  is opened on `tailscale0` only; `services.openssh.openFirewall = false`
  keeps it closed everywhere else.
- **Version managers** — rustup is kept (rust-analyzer & friends work better
  with it), node/ruby come from nixpkgs, and `mise` still works for
  per-project runtimes because `programs.nix-ld.enable = true` lets its
  downloaded binaries run. rbenv, nvm, pyenv, ghcup, juliaup, RVM, opam from
  the old `.bashrc` were dropped — use mise or a `nix shell` instead.
- **Snaps** (`yazi`, `pinta`) → plain nixpkgs packages.
- **`gem install tmuxinator`** → `pkgs.tmuxinator`.
- **`cargo install tealdeer`**, **webi shfmt**, **copr lazygit** → nixpkgs.
  Note: lazygit was pinned to 0.52.0 in mise; nixpkgs ships whatever 25.11
  has. Pin via mise again if the exact version matters.
- **polybar** is built with `i3Support` and `pulseSupport` (the config uses
  `internal/i3` and `internal/pulseaudio`).
- **Fonts**: `font-awesome`, `roboto` (includes Condensed),
  `nerd-fonts.jetbrains-mono` are installed system-wide for polybar/ghostty.
- **Not in nixpkgs**: `ondir` (the bash hooks no-op gracefully without it)
  and `pantry` (its `recipes.toml` is still symlinked for when you build it
  yourself, e.g. via `cargo install` — works thanks to nix-ld).
- **Doom Emacs** isn't managed here (it wasn't in `setup.sh` either) —
  `doom/` still has to be wired up manually if you use it on this machine.
- Dropped dead `.bashrc` weight: Spark, SML/NJ, Gambit, JetBrains Toolbox,
  Google Cloud SDK, Oracle CLI, Postgres.app, Homebrew, envman. Add back as
  needed (gcloud is `pkgs.google-cloud-sdk`).
- **nvim/mason caveat**: LSPs installed *by mason* are generic binaries —
  they run thanks to nix-ld, but the ones the config actually uses are also
  provided natively (`lua-language-server`, `clangd`, `harper`, `stylua`,
  `black`, `shfmt`, `yamlfmt`).
