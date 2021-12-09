let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  time.timeZone = "America/Chicago";
  zramSwap.enable = true;
  powerManagement.cpuFreqGovernor = "ondemand";
  fonts.fonts = with unstable; [ ipafont baekmuk-ttf ];

  environment = {
    etc."chromium/native-messaging-hosts/org.kde.plasma.browser_integration.json".source = "${unstable.plasma-browser-integration}/etc/chromium/native-messaging-hosts/org.kde.plasma.browser_integration.json";

    variables = {
      EDITOR = "nano";
      VISUAL = "nano";
    };
  };

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    xpadneo.enable = true;
    pulseaudio.enable = false;
    bluetooth.enable = true;
    opengl.driSupport32Bit = true;
  };

  security = {
    rtkit.enable = true;

    pam.services."mado" = {
      gnupg.enable = true;
      enableKwallet = true;
    };
  };

  virtualisation = {
    waydroid.enable = true;

    libvirtd = {
      enable = true;
      package = unstable.libvirt;
      onBoot = "ignore";
      onShutdown = "shutdown";

      qemu = {
        package = unstable.qemu_full;
        ovmf.package = unstable.OVMFFull;

        swtpm = {
          enable = true;
          package = unstable.swtpm;
        };
      };
    };
  };
}
