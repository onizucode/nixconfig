{
  description = "mikastiv's flake";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOs/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zig.url = "github:mitchellh/zig-overlay";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... } @inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
         inherit system;
         config.allowUnfree = true;
      };
    in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs system; };
      modules = [
        ./configuration.nix
        ./modules/unstable-overlay.nix
        ./modules/nixos/gnome.nix
      ];
    };

    homeConfigurations.mikastiv = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs system; };
      modules = [
        ./home.nix
        ./modules/unstable-overlay.nix
        ./modules/home/starship.nix
      ];
    };
  };
}
