{ config, lib, pkgs, ... }:

with lib; let
  tetrd = pkgs.callPackage ../packages/tetrd.nix { };
in {
  options.services.tetrd.enable = mkEnableOption tetrd.meta.description;

  config = mkIf config.services.tetrd.enable {
    environment.systemPackages = [ tetrd ];

    systemd.services.tetrd = {
      description = tetrd.meta.description;
      wantedBy = [ "multi-user.target" ];

      preStart = ''
        mkdir -p /usr/bin
        ln -sf ${pkgs.nettools}/bin/{route,ifconfig} /usr/bin
      '';

      serviceConfig = {
        ExecStart = "${tetrd}/opt/Tetrd/bin/tetrd";
        Restart = "always";
        RuntimeDirectory = "tetrd";
        RootDirectory = "/run/tetrd";
        DynamicUser = true;
        PermissionsStartOnly = true;
        BindReadOnlyPaths = [ builtins.storeDir ];

        CapabilityBoundingSet = [
          "CAP_DAC_OVERRIDE"
          "CAP_NET_ADMIN"
        ];

        AmbientCapabilities = [
          "CAP_DAC_OVERRIDE"
          "CAP_NET_ADMIN"
        ];

        BindPaths = [
          "/etc"
          "/run"
          "/var"
        ];
      };
    };
  };
}
