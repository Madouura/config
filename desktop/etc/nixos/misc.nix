{ pkgs, ... }:

{
  time.timeZone = "America/Chicago";
  zramSwap.enable = true;
  security.rtkit.enable = true;
  virtualisation.waydroid.enable = true;
  fonts.fonts = with pkgs; [ ipafont baekmuk-ttf ];

  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - /etc/nixos/resources/monitors.xml"
    "L+ /var/lib/AccountsService/users/mado - - - - /etc/nixos/resources/gdm"
    "L+ /var/lib/AccountsService/icons/mado - - - - /etc/nixos/resources/avatar.png"
  ];

  environment.variables = {
    EDITOR = "nano";
    VISUAL = "nano";
  };

  hardware = {
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
    bluetooth.enable = true;
    opengl.driSupport32Bit = true;
#    xone.enable = true;
  };
}