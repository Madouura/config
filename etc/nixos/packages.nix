{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ### System ###
      ## Utilities ##
        # Hardware #
        lm_sensors          # Hardware temperature and voltage
        pciutils            # List PCI devices
        usbutils            # List USB devices
        msr-tools           # CPU MSR stuff

        # Statistics #
        htop                # System monitor
        nload               # Network monitor

        # Storage #
        gptfdisk            # GPT partition manager

        # Network #
        ebtables            # Firewall
        dnsmasq             # DNS stuff

        # Virtualization #
        virtiofsd           # Host filesystem accessible by virtual machine

        # Terminal #
        screen              # Multiplex several terminals

    ### User ###
      ## Utilities ##
        # Misc #
        direnv              # Dynamic environment variables
        protonup            # Update proton GE
        chrome-gnome-shell  # GNOME-browser integration
        gnome.gnome-tweaks  # Extended GNOME settings
        gamescope           # Micro-compositor for Steam
        mangohud            # Game performance overlay

      ## GUI ##
        # Utilities #
        goverlay

        # Office #
        libreoffice         # It's like MS Office, but free

        # Development #
        vscodium            # Text editor with IDE features

        # Internet #
        discord             # Cancer
        qbittorrent         # Torrent client
        firefox             # Web browser
        chiaki              # PS4/5 remote play

        # Media #
        easyeffects         # Audio tuning/effects for pipewire
        gimp                # Meme maker
        krita               # Art maker
        mpv                 # Video player
        youtube-dl          # Download videos from various sites
        ncmpcpp             # Terminal-based music player connected to MPD

        # Emulation #
        yuzu                # Nintendo Switch
        dolphinEmu          # Nintendo GameCube/Wii
        ares                # Retro
        pcsx2               # Sony Playstation 2
        rpcs3               # Sony Playstation 3

        # Virtualization #
        virtmanager         # Manage your virtual machines

        # Crypto #
        monero-gui          # Official Monero client
        monero-cli          # Official Monero client (CLI)
        ledger-live-desktop # Official Ledger hardware wallet client
        p2pool              # Monero mining
        xmrig               # Monero mining
  ];
}
