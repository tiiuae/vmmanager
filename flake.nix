{
  description = "A flake for building VMmanager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }: let
    systems = with flake-utils.lib.system; [
      x86_64-linux
      aarch64-linux
    ];
  in
    flake-utils.lib.eachSystem systems (system: {
      packages = let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        vmmanager = pkgs.callPackage ./vmmanager.nix {};
      };

      # Allows formatting files with `nix fmt`
      formatter = nixpkgs.legacyPackages.${system}.alejandra;
    });
}
