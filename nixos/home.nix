{ config, pkgs, lib, ... }:

let
  # Source dotfiles relative to this flake checkout so the repo can live
  # anywhere on the installed system.
  dotrc = ./..;
  link = path: "${dotrc}/${path}";
in
{
  home.username = "jamestjw";
  home.homeDirectory = "/home/jamestjw";
  home.stateVersion = "25.11"; # do not change after first install

  # ------------------------------------------------------------------
  # Packages (from setup.sh, mise/config.toml, .tool-versions, i3 config)
  # ------------------------------------------------------------------
  home.packages = with pkgs; [
    # CLI tools (setup.sh)
    btop
    bat
    fswatch
    xclip
    yazi          # was a snap
    tealdeer
    tmuxinator    # was `gem install tmuxinator`
    difftastic    # git difftool
    lazygit       # was copr atim/lazygit; mise pinned 0.52.0

    # Formatters / LSPs (mise config.toml + asdf .tool-versions)
    babashka
    black
    fd
    harper              # harper-ls
    kubernetes-helm
    shfmt               # was webi.sh installer
    stylua
    yamlfmt
    yq-go               # mikefarah yq, what mise installs
    clang-tools         # clangd
    lua-language-server

    # Things the nvim config needs at runtime (lazy.nvim, treesitter, telescope)
    gcc
    gnumake
    unzip
    ripgrep

    # Languages / version managers. mise still works for per-project
    # runtimes thanks to programs.nix-ld in configuration.nix; rustup
    # replaces the rustup.rs curl|sh. rbenv/nvm/pyenv/ghcup/juliaup from
    # .bashrc are dropped — use mise or nix shells instead.
    mise
    rustup
    nodejs_22
    pnpm
    ruby          # was rbenv 3.1.2

    # Desktop apps & i3 helpers (i3 config, polybar/launch.sh)
    ghostty
    kitty
    (polybar.override { i3Support = true; pulseSupport = true; })
    rofi
    feh
    maim
    xdotool
    xautolock
    dex
    networkmanagerapplet
    brave
    evince
    pinta         # was a snap
    xorg.xrandr   # scripts/bright, polybar/launch.sh
    xorg.xset
    xorg.setxkbmap

    # Misc from .bash_aliases
    rclone        # mnt_gdrive
    opencode      # alias oc

    # Not in nixpkgs: ondir (cd hooks — .bashrc degrades gracefully without
    # it), pantry (recipes.toml is symlinked below for when you install it).
  ];

  # ------------------------------------------------------------------
  # Dotfiles symlinked from the repo (replaces setup.sh)
  # ------------------------------------------------------------------
  xdg.configFile = {
    "nvim".source = link "nvim";
    "helix".source = link "helix";
    "i3".source = link "i3";
    "kitty".source = link "kitty";
    "ghostty".source = link "ghostty";
    "polybar".source = link "polybar";
    "rofi".source = link "rofi";
    "harper-ls".source = link "harper-ls";
    "mise".source = link "mise";
    "pantry".source = link "pantry";
    "Thunar".source = link "Thunar";
  };

  home.file = {
    ".XCompose".source = link ".XCompose";
    ".ondirrc".source = link "ondir/.ondirrc";
    ".claude/settings.json".source = link "claude/settings.json";
    ".gitignore_global".source = link "git/.gitignore_global";
    "scripts".source = link "scripts"; # i3 binds $HOME/scripts/bright etc.
  };

  # ------------------------------------------------------------------
  # Bash (native translation of bash/.bashrc + .bash_aliases, minus the
  # Fedora/macOS-specific PATH cruft and version-manager shims)
  # ------------------------------------------------------------------
  programs.bash = {
    enable = true;

    shellAliases = {
      ll = "ls -ahlF";
      ".." = "cd ..";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      ggp = "git reflog | grep -Pio '(?<=moving from ).+(?= to)' | uniq | head -n10";
      cdd = "cd ~/Documents";
      cdmp = "cd ~/Documents/myprojects";
      cdp = "cd `xclip -selection clipboard`";
      cds = "cd ~/Documents/sollum";
      cpecho = "xclip -selection clipboard -rmlastnl && xclip -selection clipboard";
      pbpaste = "xclip -selection clipboard";
      cr = "git branch --show-current | cpecho";
      pwd = "builtin pwd | cpecho";
      lg = "lazygit";

      # Git
      gitm = "git checkout main";
      gdh = "git diff HEAD";
      gitaa = "git add -u && git commit --amend";
      gprush = "git pull --rebase origin main && git push";

      # nvim (vim itself is aliased by programs.neovim.vimAlias)
      nv = "nvim";
      nvconf = "nvim ~/.config/nvim";

      # Emacs
      dr = "doom run";

      mnt_gdrive = "rclone mount google-drive: ~/drive/";
      oc = "opencode";
    };

    initExtra = ''
      export GPG_TTY=$(tty)

      # Functions from .bash_aliases
      mkcdir() {
        mkdir -p -- "$1" && cd -P -- "$1"
      }

      function pkill() {
        local pid
        pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
        kill -9 $pid
        echo -n "Killed $1 (process $pid)"
      }

      sourceenv() {
        source $1/bin/activate
      }

      touch2() { mkdir -p "$(dirname "$1")" && touch "$1"; }

      # yazi with cwd-on-exit
      function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd"
        fi
        rm -f -- "$tmp"
      }

      # mise (config symlinked at ~/.config/mise)
      [ -x "$(which mise)" ] && eval "$(mise activate bash)"

      # ondir hooks; zoxide is initialised by home-manager with --no-cmd,
      # so z/zi are defined here (wrapped with ondir when available).
      if command -v ondir 2>&1 >/dev/null; then
        cd() {
          builtin cd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
        }
        z() {
          __zoxide_z "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
        }
        pushd() {
          builtin pushd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
        }
        popd() {
          builtin popd "$@" && eval "`ondir \"$OLDPWD\" \"$PWD\"`"
        }
        eval "`ondir /`"
      else
        z() {
          __zoxide_z "$@"
        }
      fi

      zi() {
        __zoxide_zi "$@"
      }
    '';
  };

  home.sessionVariables = {
    FCEDIT = "nvim"; # so `fc` uses neovim (EDITOR is set by programs.neovim)
    GOPATH = "$HOME/Documents/go";
    GOBIN = "$HOME/Documents/go/bin";
    # Erlang builds via mise/kerl
    KERL_BUILD_BACKEND = "git";
    KERL_CONFIGURE_OPTIONS = "--without-javac --with-dynamic-trace=systemtap";
  };

  home.sessionPath = [
    "$HOME/scripts"
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/Documents/go/bin"
  ];

  # Shell niceties previously wired up by hand in .bashrc
  programs.fzf.enable = true;
  programs.zoxide = {
    enable = true;
    options = [ "--no-cmd" ]; # z/zi defined in initExtra above
  };
  programs.atuin = {
    enable = true;
    flags = [ "--disable-up-arrow" ];
  };
  programs.oh-my-posh = {
    enable = true;
    settings = builtins.fromJSON (builtins.readFile ../oh-my-posh/themes/montys.omp.json);
  };

  # ------------------------------------------------------------------
  # Git (native translation of git/.gitconfig)
  # ------------------------------------------------------------------
  programs.git = {
    enable = true;
    userName = "James Tan";
    userEmail = "james_tan97@outlook.com";
    signing = {
      key = "C20EBFFB502C9F49";
      signByDefault = true; # commit.gpgsign + tag.gpgSign
    };
    lfs.enable = true;
    aliases = {
      co = "checkout";
      oc = "checkout";
      ci = "commit";
      st = "status";
      br = "branch";
      hist = ''log --pretty=format:"%h %ad | %s%d [%an]" --graph --date=short -n15'';
      a = "add .";
      au = "add -u";
      pfl = "push --force-with-lease";
      prom = "pull --rebase origin main";
      pro = "pull --rebase origin";
      psetup = "push --set-upstream origin $(git branch --show-current)";
      cp = "cherry-pick";
      mc = "merge --continue --no-edit";
      dft = "difftool";
      dlog = "!f() { GIT_EXTERNAL_DIFF=difft git log -p --ext-diff $@; }; f";
    };
    extraConfig = {
      core = {
        excludesfile = "~/.gitignore_global";
        hooksPath = "~/.githooks/";
        editor = "nvim";
      };
      rerere.enabled = true;
      url."https://".insteadOf = "git://";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      diff.tool = "difftastic";
      difftool = {
        prompt = false;
        difftastic.cmd = ''difft "$LOCAL" "$REMOTE"'';
      };
      pager.difftool = true;
      include.path = "~/.gitconfig-local";
    };
  };

  # ------------------------------------------------------------------
  # Tmux (.tmux.conf)
  # ------------------------------------------------------------------
  programs.tmux = {
    enable = true;
    mouse = true;
    shortcut = "a"; # prefix C-a, unbinds C-b, C-a C-a sends prefix
  };

  # ------------------------------------------------------------------
  # Neovim — mise pinned 0.11.3; nixos-25.11 ships 0.11.x. The lazy.nvim
  # config is symlinked at ~/.config/nvim (see above).
  # ------------------------------------------------------------------
  programs.neovim = {
    enable = true;
    defaultEditor = true; # EDITOR=nvim
    viAlias = true;
    vimAlias = true;
  };

  # GPG agent for commit signing (GPG_TTY exported in initExtra)
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
  };
}
