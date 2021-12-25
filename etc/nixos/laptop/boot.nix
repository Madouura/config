{
  boot.initrd.luks.devices."cryptwrot".device = "/dev/disk/by-uuid/7128b6e5-af2b-41d8-893a-3252af7a98ec";

  fileSystems = {
    "/mnt/stor".options = [ "discard" "noatime" "commit=60" "barrier=0" ];
  };
}
