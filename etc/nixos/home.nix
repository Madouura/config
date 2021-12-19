{ pkgs, ... }:

{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    users.mado = {
      home = {
        stateVersion = "21.11";

        packages = with pkgs; [
          # Utilities
          appimage-run
          virt-manager
          pulseaudio
          helvum
          looking-glass-client
          gnome.gnome-tweaks

          # Development
          gnumake
          gcc

          # Internet
          discord
          qbittorrent
          mullvad-vpn

          # Media
          ffmpeg
          youtube-dl
          easyeffects
          obs-studio
          gimp

          # Games
          yuzu-ea
#          ares
        ];
      };

      services.mpd = {
        enable = true;
        musicDirectory = /home/mado/Music;

        extraConfig = ''
          audio_output {
            type            "pipewire"
            name            "PipeWire Sound Server"
          }
        '';
      };

      programs = {
        home-manager.enable = true;
        ncmpcpp.enable = true;
        vscode.enable = true;

        bash = {
          enable = true;
          historyControl = [ "erasedups" ];

          shellAliases = {
            nupgrade = "nix-channel --update && sudo nixos-rebuild switch --upgrade";
            ncollect = "sudo nix-collect-garbage -d";
          };
        };

        git = {
          enable = true;
          userName = "Madoura";
          userEmail = "madouura@gmail.com";
          signing.signByDefault = true;
        };

        chromium = {
          enable = true;

          extensions = [
            { id = "gphhapmejobijbbhgpjhcjognlahblep"; } # Gnome Shell Integration
            { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # Ublock Origin
            { id = "ponfpcnoihfmfllpaingbgckeeldkhle"; } # Enhancer for YouTube
            { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock for YouTube
            { id = "dneaehbmnbhcippjikoajpoabadpodje"; } # Old Reddit Redirect
            { id = "mpbjkejclgfgadiemmefgebjfooflfhl"; } # Buster Captcha Solver
            { id = "moicohcfhhbmmngneghfjfjpdobmmnlg"; } # LiveTL
            { id = "hkgfoiooedgoejojocmhlaklaeopbecg"; } # Picture in Picture
            { id = "jinjaccalgkegednnccohejagnlnfdag"; } # Violentmonkey
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
            screenshot-directory = "/home/mado/Pictures/Screenshots";
          };
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
    };
  };
}
