let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  time.timeZone = "America/Chicago";
  zramSwap.enable = true;
  powerManagement.cpuFreqGovernor = "ondemand";
  security.rtkit.enable = true;
  fonts.fonts = with unstable; [ ipafont baekmuk-ttf ];

  environment ={
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

    opengl = {
      driSupport32Bit = true;
      extraPackages = with unstable; [ amdvlk ];
      extraPackages32 = with unstable; [ driversi686Linux.amdvlk ];
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
