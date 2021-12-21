{ pkgs, ... }:

{
  time.timeZone = "America/Chicago";
  zramSwap.enable = true;
  powerManagement.cpuFreqGovernor = "ondemand";
  fonts.fonts = with pkgs; [ ipafont baekmuk-ttf ];
  security.rtkit.enable = true;
  systemd.tmpfiles.rules = [ "f /dev/shm/looking-glass 0660 mado kvm -" ];

  environment.variables = {
    EDITOR = "nano";
    VISUAL = "nano";
  };

  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
    bluetooth.enable = true;
    opengl.driSupport32Bit = true;
  };

  virtualisation = {
    waydroid.enable = true;
    docker.enable = true;

    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";
      qemu.swtpm.enable = true;
    };
  };
}
