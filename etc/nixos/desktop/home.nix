let
  baseConfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseConfig; };
in {
  home-manager = {
    users.mado = {
      programs.git.signing.key = "C5FF0C6F823C620404B9E9872D2F0C76BF6A80D4";

      home.packages = with unstable; [
        pulseaudio
        scream
        dolphinEmuMaster
      ];

      systemd.user.services.scream-ivshmem = {
        Install.WantedBy = [ "default.target" ];

        Unit = {
          Description = "Scream IVSHMEM pulse receiver";
          After = [ "pipewire-pulse.service" ];
          Wants = [ "pipewire-pulse.service" ];
        };

        Service = {
          ExecStart = "${unstable.scream}/bin/scream -m /dev/shm/scream-ivshmem -o pulse -n 'Windows 11 VM'";
          Restart = "always";
        };
      };
    };
  };
}
