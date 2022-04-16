{ pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    users.mado = {
      home = {
        stateVersion = "21.11";
        enableNixpkgsReleaseCheck = true;

        packages = with pkgs; [
          # Utilities
          appimage-run
          pulseaudio
          helvum
          protonup
          winetricks
          mangohud
          goverlay
          gnome.gnome-tweaks

          # Development
          gnumake
          gcc
          libreoffice

          # Internet
          discord
          qbittorrent
          mullvad-vpn
          firefox

          # Media
          ffmpeg
          youtube-dl
          easyeffects
          obs-studio
          gimp

          # Games
          yuzu
          dolphinEmuMaster
          ares
          wine
          chiaki
        ];
      };

      services = {
        mpdris2.enable = true;

        mpd = {
          enable = true;
          musicDirectory = /home/mado/Music;

          extraConfig = ''
            audio_output {
              type            "pipewire"
              name            "PipeWire Sound Server"
            }
          '';
        };
      };

      programs = {
        home-manager.enable = true;
        ncmpcpp.enable = true;

        bash = {
          enable = true;
          historyControl = [ "erasedups" ];
          bashrcExtra = ''export XDG_DATA_HOME="/home/mado/.local/share"'';

          shellAliases = {
            nupgrade = "nix-channel --update && sudo nix-channel --update && sudo nixos-rebuild switch --upgrade";
            ncollect = "sudo nix-collect-garbage -d";
          };
        };

        git = {
          enable = true;
          userName = "Madoura";
          userEmail = "madouura@gmail.com";

          signing = {
            signByDefault = true;
            key = "106371E741F260C92980E6E259B6B50D67575615";
          };
        };

        vscode = {
          enable = true;
          package = pkgs.vscodium;
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
      };

      accounts.email.accounts.madoura = {
        name = "Madoura";
        realName = "Madoura";
        userName = "madouura";
        address = "madouura@gmail.com";
        flavor = "gmail.com";
        primary = true;
      };
    };
  };
}
