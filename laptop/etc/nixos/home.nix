{ pkgs, ... }:

let
  fixAudio = pkgs.writeShellScript "fix-audio.sh" ''
    sleep 5
    pactl set-card-profile alsa_card.usb-Schiit_Audio_Schiit_Unison_Modius-00 output:iec958-stereo
    pactl set-card-profile alsa_card.usb-Focusrite_Scarlett_Solo_USB_Y7DZDPB160B058-00 input:iec958-stereo
  '';
in {
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

          # Internet
          discord
          qbittorrent
          mullvad-vpn
          brave

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
            key = "8A39BFA5C357764D26FBE142A4520F4F74CF98C5";
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

      xdg.desktopEntries.fix-audio = {
        name = "Fix Audio";
        exec = "${fixAudio}";
        type = "Application";
      };
    };
  };
}