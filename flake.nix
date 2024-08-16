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
      overlay-unstable = self: super: {
        unstable = import nixpkgs-unstable {
          inherit system;
          config.allowUnfree = true;
        };
      };
    in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.overlays = [ overlay-unstable ]; }
        ./configuration.nix
#        ./modules/nixos/gnome.nix
        ./modules/nixos/hyprland.nix
      ];
    };

    homeConfigurations.mikastiv = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.overlays = [ overlay-unstable inputs.zig.overlays.default ]; }
        ./home.nix
      ];
    };
  };
}
