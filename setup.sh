# TODO: Setup symlinks
# symlink git, bash, nvim, i3 stuff

# TODO: neovim

# TODO: Setup python
# TODO: Setup rust
# TODO: Setup ocaml

# TODO: Setup ruby
# TODO: Setup tmuxinator (and tmux)

# TODO: setup ondir

# TODO: install tools
#   btop

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

# Install mise package manager
sudo dnf install mise -y
