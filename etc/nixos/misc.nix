let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  time.timeZone = "America/Chicago";
  zramSwap.enable = true;
  powerManagement.cpuFreqGovernor = "ondemand";
  security.rtkit.enable = true;
  virtualisation.waydroid.enable = true;
  fonts.fonts = with unstable; [ ipafont baekmuk-ttf ];

  environment .variables = {
    EDITOR = "nano";
    VISUAL = "nano";
  };

  hardware = {
    xpadneo.enable = true;
    cpu.amd.updateMicrocode = true;
    pulseaudio.enable = false;

    opengl = {
      driSupport32Bit = true;
      extraPackages = with unstable; [ amdvlk ];
      extraPackages32 = with unstable; [ driversi686Linux.amdvlk ];
    };
  };
}
