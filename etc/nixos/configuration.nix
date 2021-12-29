{ config, ... }:

{
  system.stateVersion = "21.11";
  nixpkgs.config.allowUnfree = true;

  imports = [
    ## Default ##
    ./boot.nix
    ./hardware-configuration.nix
    ./home.nix
    ./misc.nix
    ./network.nix
    ./override.nix
    ./packages.nix
    ./programs.nix
    ./services.nix

    ## Desktop-specific ##
    ./desktop/boot.nix
    ./desktop/home.nix
    ./desktop/misc.nix
    ./desktop/network.nix
    ./desktop/services.nix

    ## Laptop-specific ##
#    ./laptop/boot.nix
#    ./laptop/configuration.nix
#    ./laptop/home.nix
#    ./laptop/misc.nix
#    ./laptop/network.nix
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
    extraGroups = [ "wheel" "kvm" "libvirtd" "corectrl" ];
  };
}
