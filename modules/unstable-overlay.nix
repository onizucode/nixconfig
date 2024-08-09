{ inputs, system, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      # unstable = nixpkgs-unstable.legacyPackages.${prev.system};
      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    })
  ];
}
