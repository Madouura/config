{ config, ... }:

{
  system.stateVersion = "21.11";
  nixpkgs.config.allowUnfree = true;

  imports = [
    <home-manager/nixos>
    ./boot.nix
    ./hardware-configuration.nix
    ./home.nix
    ./misc.nix
    ./network.nix
    ./override.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./desktop/configuration.nix
#    ./laptop/configuration.nix
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
