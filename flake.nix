{
  description = "Modular NixOS Flake Configuration for xMachine";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      nixhp = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          # Ze old monolithic way
          # ./configuration.nix

          # Ze new modularized way iz da wey
          ./hosts/nixhp
          ./modules/core
          ./modules/desktop/gnome.nix
          ./modules/programs/dev-tools.nix
          ./modules/programs/system-packages.nix
          ./modules/users/gdj.nix
        ];
      };
    };
  };
}
