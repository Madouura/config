{ config, ... }:

{
  system.stateVersion = "21.05";
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./boot.nix
    ./hardware-configuration.nix
    ./home.nix
    ./misc.nix
    ./override.nix
    ./network.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
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
    extraGroups = [ "wheel" "libvirtd" "input" "corectrl" ];
  };
}
