let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    users.mado = {
      home = {
        stateVersion = "21.05";

        packages = with unstable; [
          # Utilities
          wine
          neofetch
          appimage-run
          gnome3.gnome-tweaks
          flips
          protonup

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
          gimp
          easyeffects

          # Games
          yuzu-ea
#          ares
        ];
      };

      services.mpd = {
        enable = true;
        package = unstable.mpd;
        musicDirectory = /home/mado/Music;
      };

      programs = {
        home-manager.enable = true;

        ncmpcpp = {
          enable = true;
          package = unstable.ncmpcpp;
        };

        bash = {
          enable = true;
          historyControl = [ "erasedups" ];

          shellAliases = {
            nupgrade = "nix-channel --update && sudo nixos-rebuild switch --upgrade";
            ncollect = "sudo nix-collect-garbage -d";
          };

          bashrcExtra = ''
            export XDG_DATA_HOME="/home/mado/.local/share"
          '';
        };

        git = {
          enable = true;
          userName = "Madoura";
          userEmail = "madouura@gmail.com";
        };

        chromium = {
          enable = true;
          package = unstable.chromium;

          extensions = [
            { id = "gphhapmejobijbbhgpjhcjognlahblep"; } # Gnome Shell Integration
            { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # Ublock Origin
            { id = "ponfpcnoihfmfllpaingbgckeeldkhle"; } # Enhancer for YouTube
            { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock for YouTube
            { id = "dneaehbmnbhcippjikoajpoabadpodje"; } # Old Reddit Redirect
            { id = "mpbjkejclgfgadiemmefgebjfooflfhl"; } # Buster Captcha Solver
            { id = "moicohcfhhbmmngneghfjfjpdobmmnlg"; } # LiveTL

          ];
        };

        mpv = {
          enable = true;
          package = unstable.mpv;
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

        vscode = {
          enable = true;
          package = unstable.vscodium;
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
