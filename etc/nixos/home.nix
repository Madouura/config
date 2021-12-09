{ pkgs, ... }:

let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
  ares = pkgs.callPackage ./packages/ares.nix { };
in {
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    users.mado = {
      home = {
        stateVersion = "21.11";

        packages = with unstable; [
          # Utilities
          neofetch
          appimage-run
          flips
          protonup
          virt-manager
          pulseaudio
          helvum

          # Development
          gnumake
          gcc

          # Internet
          discord
          qbittorrent
          mullvad-vpn
          akonadi
          kmail
          thunderbird
          birdtray

          # Media
          ffmpeg
          youtube-dl
          easyeffects
          krita
          obs-studio

          # Games
          yuzu-ea
          ares
        ] ++ (with unstable.libsForQt5.kdeApplications; [
          akonadiconsole
          akonadi-search
          ark
        ]);
      };

      services = {
        mpd = {
          enable = true;
          package = unstable.mpd;
          musicDirectory = /home/mado/Music;

          extraConfig = ''
            audio_output {
              type            "pipewire"
              name            "PipeWire Sound Server"
            }
          '';
        };

        kdeconnect = {
          enable = true;
          indicator = true;
        };
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
          signing.signByDefault = true;
        };

        chromium = {
          enable = true;
          package = unstable.chromium;

          extensions = [
            { id = "cimiefiiaegbelhefglklhhakcgmhkai"; } # Plasma Integration
            { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # Ublock Origin
            { id = "ponfpcnoihfmfllpaingbgckeeldkhle"; } # Enhancer for YouTube
            { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock for YouTube
            { id = "dneaehbmnbhcippjikoajpoabadpodje"; } # Old Reddit Redirect
            { id = "mpbjkejclgfgadiemmefgebjfooflfhl"; } # Buster Captcha Solver
            { id = "moicohcfhhbmmngneghfjfjpdobmmnlg"; } # LiveTL
            { id = "hkgfoiooedgoejojocmhlaklaeopbecg"; } # Picture in Picture
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
