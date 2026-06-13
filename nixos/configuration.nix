{ config, pkgs, ... }:

{
  imports = [
    # Generate this on the target machine with `nixos-generate-config`
    # and copy it next to this file.
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.systemd-boot.enable = false;

  networking.hostName = "nixos"; # change me (and the flake output name)
  networking.networkmanager.enable = true;

  time.timeZone = "America/Montreal";
  i18n.defaultLocale = "en_US.UTF-8"; # replaces `export LC_ALL=en_US.UTF-8` in .bashrc

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # --- Desktop: X11 + i3 (Fedora i3 spin equivalent) ---
  services.xserver = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ dmenu i3lock i3status ];
    };
    xkb = {
      layout = "us";
      # i3 config also runs `setxkbmap -option compose:ralt`; this makes it
      # the default even outside i3.
      options = "compose:ralt";
    };
    displayManager.lightdm.enable = true;
  };
  services.displayManager.defaultSession = "none+i3";

  # Audio: PipeWire with PulseAudio compat (i3 volume keys use pactl).
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # scripts/kbdbacklight talks to UPower over D-Bus.
  services.upower.enable = true;

  # Thunar (uca.xml/accels.scm are symlinked from home.nix).
  programs.thunar.enable = true;
  services.gvfs.enable = true;    # mounts, trash
  services.tumbler.enable = true; # thumbnails

  # --- Tailscale + firewall (equivalent of firewall.sh) ---
  # firewalld zone "tailscale" with target DROP + ssh service becomes:
  # NixOS firewall is default-deny inbound on every interface (= DROP),
  # and we punch SSH open only on tailscale0.
  services.tailscale = {
    enable = true;
    openFirewall = true; # tailscale's own UDP port on the underlay
  };
  networking.firewall = {
    enable = true;
    interfaces."tailscale0".allowedTCPPorts = [ 22 ];
    # Deliberately NOT in trustedInterfaces — same intent as the DROP zone.
  };
  services.openssh = {
    enable = true;
    openFirewall = false; # reachable via tailscale0 only (rule above)
  };

  # mise/rustup/lazy.nvim/mason download generic Linux binaries that expect
  # /lib64/ld-linux; nix-ld lets them run unpatched.
  programs.nix-ld.enable = true;

  # Fonts from setup.sh (used by polybar, ghostty, kitty).
  fonts.packages = with pkgs; [
    font-awesome              # fontawesome-6-{free,brands}-fonts
    roboto                    # includes Roboto Condensed
    nerd-fonts.jetbrains-mono # jetbrainsmono-nerd-fonts (terra repo)
  ];

  users.users.jamestjw = {
    isNormalUser = true;
    description = "James Tan";
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };

  environment.systemPackages = with pkgs; [ git vim wget curl ];

  system.stateVersion = "25.11"; # do not change after first install
}
