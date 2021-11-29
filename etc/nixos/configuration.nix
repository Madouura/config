{ config, ... }:

{
  system.stateVersion = "21.05";
  nixpkgs.config.allowUnfree = true;

  imports = [
    ## Local ##
    ./boot.nix
    ./home.nix
    ./misc.nix
    ./override.nix
    ./packages.nix
    ./programs.nix
    ./services.nix

    ## Desktop-specific ##
    ./desktop/boot.nix
    ./desktop/hardware-configuration.nix
    ./desktop/home.nix
    ./desktop/misc.nix
    ./desktop/network.nix
    ./desktop/override.nix
    ./desktop/services.nix

    ## Laptop-specific ##
#    ./laptop/boot.nix
#    ./laptop/hardware-configuration.nix
#    ./laptop/misc.nix
#    ./laptop/network.nix
#    ./laptop/override.nix
#    ./laptop/packages.nix
#    ./laptop/services.nix

    ## External ##
    <home-manager/nixos>
  ];

  nix = {
    autoOptimiseStore = true;

    gc = {
      automatic = true;
      dates = "weekly";
    };
  };

  users.users.mado = {
    isNormalUser = true;
    description = "Madoura";
    extraGroups = [ "wheel" "corectrl" ];
  };
}
