{ config, ... }:

{
  system.stateVersion = "22.05";
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./boot.nix
    ./hardware-configuration.nix
    ./home.nix
    ./misc.nix
    ./network.nix
    ./overlays.nix
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
    extraGroups = [ "wheel" "kvm" "libvirtd" "corectrl" "rtkit" ];
  };
}
