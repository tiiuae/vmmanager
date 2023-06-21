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
    flake-utils.lib.eachSystem systems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.vmmanager = pkgs.libsForQt5.callPackage ./vmmanager.nix {};
      packages.default = self.packages.${system}.vmmanager;

      # Development shell with Qt Creator, enter with `nix develop`
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          libsForQt5.qmake
          libsForQt5.qtbase
          libsForQt5.qtdeclarative
          qtcreator
        ];
      };

      # Allows formatting files with `nix fmt`
      formatter = pkgs.alejandra;
    });
}
