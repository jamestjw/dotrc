#!/bin/bash
set -e

DOTFILES_DIR=$(pwd)
CONFIG_DIR="$HOME/.config"

mkdir -p "$CONFIG_DIR"

config_dirs=(
    "nvim"
    "i3"
    "kitty"
    "helix"
    "polybar"
    "rofi"
    "ghostty"
    "oh-my-posh"
    "harper-ls"
    "mise"
)

for dir in "${config_dirs[@]}"; do
    if [ -d "$DOTFILES_DIR/$dir" ]; then
        ln -snf "$DOTFILES_DIR/$dir" "$CONFIG_DIR/$dir"
        echo "   Symlinked ~/$dir"
    else
        echo "   Warning: Directory $DOTFILES_DIR/$dir not found. Skipping."
    fi
done

ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
ln -sf "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
ln -sf "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
ln -sf "$DOTFILES_DIR/bash/.bash_profile" "$HOME/.bash_profile"
ln -sf "$DOTFILES_DIR/bash/.bash_aliases" "$HOME/.bash_aliases"

source $HOME/.bashrc

sudo dnf update -y
sudo dnf install snapd -y

# Install mise package manager
sudo dnf install mise -y
mise install
mise use --global neovim@version

# TODO: neovim
# TODO: Setup python

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
rustc --version
# TODO: Setup ocaml

# Ruby
sudo dnf install -y git-core gcc rust patch make bzip2 openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel perl-FindBin perl-lib perl-File-Compare
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install 3.1.2
rbenv global 3.1.2
# Setup tmux and tmuxinator
sudo dnf install tmux -y
gem install tmuxinator

# TODO: setup ondir

# System monitor
sudo dnf install btop -y

# Lazygit
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit -y

sudo dnf install xclip -y # Clipboard

# Formatters
curl -sS https://webi.sh/shfmt | sh # shell formatter

# Fancy cat
sudo dnf install bat -y

sudo dnf install fswatch -y

# Terminal file manager
sudo snap install yazi --classic

# Fonts
## These four are used by polybar, i.e. look at polybar/config.ini
sudo dnf install fontawesome-6-free-fonts -y
sudo dnf install fontawesome-6-brands-fonts -y
sudo dnf install google-roboto-condensed-fonts -y
sudo dnf config-manager --add-repo https://terra.fyralabs.com/terra.repo -y
sudo dnf install jetbrainsmono-nerd-fonts -y

# Image editing app (kolourpaint is also pretty decent)
sudo snap install pinta

# Document viewer (e.g. PDF)
sudo dnf install evince -y

# Friendlier version of `man`
cargo install tealdeer
