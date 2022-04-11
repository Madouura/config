{ config, ... }:

{
  system.stateVersion = "21.11";
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./boot.nix
    ./hardware-configuration.nix
    ./home.nix
    ./misc.nix
    ./network.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
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
