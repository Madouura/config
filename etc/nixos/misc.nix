let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  time.timeZone = "America/Chicago";
  zramSwap.enable = true;
  security.rtkit.enable = true;
  fonts.fonts = with unstable; [ ipafont baekmuk-ttf ];

  environment .variables = {
    EDITOR = "nano";
    VISUAL = "nano";
  };

  hardware = {
    xpadneo.enable = true;
    cpu.amd.updateMicrocode = true;
    opengl.driSupport32Bit = true;
    pulseaudio.enable = false;
  };
}
