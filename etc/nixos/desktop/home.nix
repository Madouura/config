{ pkgs, ... }:

let
  win11Start = pkgs.writeShellScript "win11-vm-start.sh" ''
    virsh --connect=qemu:///system start win11
    looking-glass-client
  '';

  fixAudio = pkgs.writeShellScript "fix-audio.sh" ''
    sleep 4
    pactl set-card-profile alsa_card.usb-Schiit_Audio_Schiit_Unison_Modius-00 output:iec958-stereo
    pactl set-card-profile alsa_card.usb-Focusrite_Scarlett_Solo_USB_Y7DZDPB160B058-00 input:iec958-stereo
  '';
in {
  home-manager.users.mado = {
    programs.git.signing.key = "7DFD1583D5AC9A61ED3D714C94E0BBB3B85A14FF";

    home.file.win11-vm-start = {
      source = win11Start;
      target = ".local/bin/win11-vm-start.sh";
    };

    xdg.desktopEntries.fix-audio = {
      name = "Fix Audio";
      exec = "${fixAudio}";
      type = "Application";
    };
  };
}
