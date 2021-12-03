{ config, lib, pkgs, ... }:

with lib; let
  tetrd = pkgs.callPackage ../packages/tetrd.nix { };
in {
  options.services.tetrd.enable = mkEnableOption tetrd.meta.description;

  config = mkIf config.services.tetrd.enable {
    environment.systemPackages = [ pkgs.nettools tetrd ];

    systemd = {
      # Seems to need root access for /run/tetrd.sock, which seems to be hard-coded
      services.tetrd = {
        description = tetrd.meta.description;
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          ExecStart = "${tetrd}/opt/Tetrd/bin/tetrd";
          Restart = "always";
        };
      };

      # Unfortunately, it appears these paths are hard-coded in
      tmpfiles.rules = [
        "L+ /usr/bin/route - - - - ${pkgs.nettools}/bin/route"
        "L+ /usr/bin/ifconfig - - - - ${pkgs.nettools}/bin/ifconfig"
      ];
    };
  };
}
