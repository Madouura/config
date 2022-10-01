{ pkgs, ... }:

{
  programs = {
    thefuck.enable = true;
    dconf.enable = true;
    corectrl.enable = true;
    gnupg.agent.enable = true;

    git = {
      enable = true;
      lfs.enable = true;
    };

    bash.shellAliases = {
      nupgrade = "nix-channel --update && sudo nix-channel --update && sudo nixos-rebuild switch --upgrade";
      ncollect = "sudo nix-collect-garbage -d";
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    nano = {
      syntaxHighlight = true;

      nanorc = ''
        set nowrap
        set tabstospaces
        set tabsize 2
      '';
    };

    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };

    gamemode = {
      enable = true;

      settings = {
        general = {
          renice = 10;
        };

        gpu = {
          apply_gpu_optimisations = "accept-responsibility";
          gpu_device = 0;
          amd_performance_level = "high";
        };
      };
    };
  };
}
