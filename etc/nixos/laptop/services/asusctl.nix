{ config, lib, pkgs, ... }:

with lib; let
  asusctl = pkgs.callPackage ../packages/asusctl/default.nix { };
in {
  ###### interface

  options = {
    services.asusctl = {
      enable = mkOption {
        description = ''
          Use asusctl to control the lighting, fan curve, GPU mode and more
          on supported Asus laptops.
        '';
        type = types.bool;
        default = false;
      };
    };
  };

  ###### implementation

  config = mkIf config.services.asusctl.enable {
    services.supergfxctl.enable = true;
    environment.systemPackages = [ asusctl ];
    services.dbus.packages = [ asusctl ];
    services.udev.packages = [ asusctl ];
    systemd.packages = [ asusctl ];
  };
}
