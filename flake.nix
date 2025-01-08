{
  description = "mikastiv's flake";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    zig.url = "github:mitchellh/zig-overlay";
    zig.inputs.nixpkgs.follows = "nixpkgs";
    ghostty.url = "github:ghostty-org/ghostty";
  };

  outputs = { self, nixpkgs, home-manager, ghostty, ... } @inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
         inherit system;
         config.allowUnfree = true;
      };
    in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        { environment.systemPackages = [
            ghostty.packages.x86_64-linux.default
          ];
        }
        ./configuration.nix
        ./modules/nixos/gnome.nix
#        ./modules/nixos/hyprland.nix
      ];
    };

    homeConfigurations.mikastiv = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit inputs; };
      modules = [
        { nixpkgs.overlays = [ inputs.zig.overlays.default ]; }
        ./home.nix
      ];
    };
  };
}
