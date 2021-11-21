{ config, lib, pkgs, ... }:

let
  tetrd = pkgs.callPackage ../packages/tetrd.nix { };
in {
  options.services.tetrd.enable = lib.mkEnableOption tetrd.meta.description;

  config = lib.mkIf config.services.tetrd.enable {
    environment.systemPackages = with pkgs; [ tetrd nettools ];

    systemd = {
      services.tetrd = {
        description = tetrd.meta.description;
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          ExecStart = "${tetrd}/opt/Tetrd/bin/tetrd";
          Restart = "always";
        };
      };

      # Unfortunately, it appears these paths are hard-coded in.
      tmpfiles.rules = [
        "L+ /usr/bin/route - - - - ${pkgs.nettools}/bin/route"
        "L+ /usr/bin/ifconfig - - - - ${pkgs.nettools}/bin/ifconfig"
      ];
    };
  };
}
