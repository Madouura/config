{ pkgs, ... }:

let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    users.mado = {
      services.mpd = {
        enable = true;
        musicDirectory = /home/mado/Music;
      };

      home = {
        stateVersion = "21.05";

        packages = with pkgs; [
          # Utilities
          unstable.virt-manager
          unstable.wine
          neofetch
          appimage-run
          gnome3.gnome-tweaks
          unstable.flips

          # Development
          gnumake
          gcc

          # Internet
          unstable.discord
          qbittorrent

          # Media
          ffmpeg
          youtube-dl
          unstable.easyeffects
          unstable.scream
          gimp
          pulseaudio

          # Games
          unstable.yuzu-ea
          unstable.dolphinEmuMaster
          unstable.higan
        ];
      };

      programs = {
        home-manager.enable = true;
        ncmpcpp.enable = true;

        bash = {
          enable = true;
          historyControl = [ "erasedups" ];

          shellAliases = {
            nupgrade = "sudo nix-channel --update && nix-channel --update && sudo nixos-rebuild switch --upgrade";
            ncollect = "sudo nix-collect-garbage -d";
          };
        };

        git = {
          enable = true;
          userName = "Madoura";
          userEmail = "madouura@gmail.com";
        };

        chromium = {
          enable = true;

          extensions = [
            { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # Ublock Origin
            { id = "ponfpcnoihfmfllpaingbgckeeldkhle"; } # Enhancer for YouTube
            { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock for YouTube
          ];
        };

        mpv = {
          enable = true;
          defaultProfiles = [ "gpu-hq" ];

          config = {
            scale = "ewa_lanczossharp";
            cscale = "ewa_lanczossharp";
            video-sync = "display-resample";
            interpolation = "";
            tscale = "oversample";
            no-border = "";
            alang = "jp,jpn,japan";
            slang = "en,eng,english";
            screenshot-template = "%F (%p)";
            screenshot-directory = "~/Pictures/Screenshots";
          };
        };

        vscode = {
          enable = true;
          package = pkgs.vscodium;
        };
      };

      accounts.email.accounts."madouura" = {
        name = "Madoura";
        realName = "Madoura";
        userName = "madouura";
        address = "madouura@gmail.com";
        flavor = "gmail.com";
        primary = true;
      };

      systemd.user.services.scream-ivshmem = {
        Install.WantedBy = [ "default.target" ];

        Unit = {
          Description = "Scream IVSHMEM pulse receiver";
          After = [ "pipewire-pulse.service" ];
          Wants = [ "pipewire-pulse.service" ];
        };

        Service = {
          ExecStart = "${pkgs.scream}/bin/scream -m /dev/shm/scream-ivshmem -o pulse -n 'Windows 11 VM'";
          Restart = "always";
        };
      };
    };
  };
}
