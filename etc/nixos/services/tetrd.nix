{ config, lib, pkgs, ... }:

{
  options.services.tetrd.enable = lib.mkEnableOption pkgs.tetrd.meta.description;

  config = lib.mkIf config.services.tetrd.enable {
    environment.systemPackages = with pkgs; [ tetrd nettools ];

    systemd = {
      # Seems to need root access for /run/tetrd.sock, which seems to be hard-coded
      services.tetrd = {
        description = pkgs.tetrd.meta.description;
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          ExecStart = "${pkgs.tetrd}/opt/Tetrd/bin/tetrd";
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
