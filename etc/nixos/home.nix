{ pkgs, ... }:

let
  win11-vm-start = pkgs.writeShellScript "win11-vm-start.sh" ''
    supergfxctl -m vfio
    virsh --connect=qemu:///system start win11
    looking-glass-client

    while true; do
      sleep 1
      virsh --connect=qemu:///system list --name --state-shutoff | grep "win11" &> /dev/null
      if [ $? == 0 ]; then break; fi
    done

    supergfxctl -m integrated
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
          virt-manager
          pulseaudio
          helvum
          looking-glass-client
          protonup
          pciutils
          usbutils
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
          dolphinEmuMaster
          ares
        ];

        file.looking-glass-client = {
          target = ".config/looking-glass/client.ini";

          text = ''
            [app]
            shmFile = /dev/kvmfr0

            [win]
            fullScreen = yes

            [spice]
            input = no
          '';
        };
      };

      services.mpd = {
        enable = true;
        musicDirectory = ~/Music;

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

      xdg.desktopEntries.windows-11-virtual-machine = {
        name = "Windows 11 Virtual Machine";
        genericName = "Start Windows Gaming VM";
        comment = "Launches a Windows VM with dedicated graphics for high-performance applications";
        exec = "${win11-vm-start}";
        icon = "/etc/nixos/misc/win11.png";
        type = "Application";
      };
    };
  };
}
