{
  description = "NixOS port of jamestjw's dotrc (Fedora i3 setup)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      mkSystem = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.jamestjw = import ./home.nix;
          }
        ];
      };
    in {
      # Install/rebuild with:
      #   sudo nixos-rebuild switch --flake ~/dotrc/nixos#jamestjw
      nixosConfigurations.jamestjw = mkSystem;
      nixosConfigurations.nixos = mkSystem;
    };
}
