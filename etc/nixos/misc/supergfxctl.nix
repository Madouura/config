{ config, lib, pkgs, ... }:

with lib; let
  supergfxctl = pkgs.callPackage ../packages/supergfxctl.nix { };
in {
  ###### interface
  options = {
    services.supergfxctl = {
      enable = mkOption {
        type = types.bool;
        default = false;

        description = ''
          Enable this option to enable control of GPU modes with supergfxctl.

          This permits you to switch between integrated, hybrid and dedicated
          graphics modes on supported laptops.
        '';
      };
    };
  };

  ###### implementation
  config = mkIf config.services.supergfxctl.enable {
    environment.systemPackages = [ supergfxctl ];
    services.dbus.packages = [ supergfxctl ];
    services.udev.packages = [ supergfxctl ];
    systemd.packages = [ supergfxctl ];
  };
}
