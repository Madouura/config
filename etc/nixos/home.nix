{ pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    users.mado = {
      home = {
        stateVersion = "22.05";
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
          direnv
          gnome.gnome-tweaks

          # Development
          gh
          gnumake
          gcc
          libreoffice
          python3

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
          vlc
          mixxx

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
            key = "C83FB29ABF63211D7C24B7A350CCE80199B1F736";
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
            sub-auto = "fuzzy";
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
