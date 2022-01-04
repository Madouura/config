{ pkgs, ... }:

let
  win11Start = pkgs.writeShellScript "win11-vm-start.sh" ''
    supergfxctl -m vfio
    virsh --connect=qemu:///system start win11
    looking-glass-client

    while true; do
      sleep 5
      virsh --connect=qemu:///system list --name --state-shutoff | grep "win11" &> /dev/null
      if [ $? == 0 ]; then break; fi
    done

    supergfxctl -m integrated
  '';
in {
  home-manager.users.mado = {
    programs.git.signing.key = "0E3038B27BE66A8E85DEBD866267114016F9F869";

    home.file.win11-vm-start = {
      source = win11Start;
      target = ".local/bin/win11-vm-start.sh";
    };
  };
}
