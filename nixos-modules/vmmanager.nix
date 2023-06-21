{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.vmmanager;
in {
  options.programs.vmmanager = {
    enable = mkEnableOption "VMManager";

    package = mkOption {
      type = types.package;
      default = pkgs.libsForQt5.callPackage ../vmmanager.nix {
        vmd-client = config.programs.vmd-client.package;
      };
      defaultText = literalExpression ''
        pkgs.libsForQt5.callPackage ../vmmanager.nix {
          vmd-client = config.programs.vmd-client.package;
        }
      '';
      description = mdDoc "The package to use for the vmmanager binary.";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      cfg.package
    ];
  };
}
