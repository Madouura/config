{ pkgs, ... }:

let
  qemuHook = pkgs.writeShellScript "qemu-hook.sh" ''
    GUEST_NAME="$1"
    OPERATION="$2"
    SUB_OPERATION="$3"
    ALLOWED_CPUS=0-7,16-23
    TOTAL_CPUS=0-31
    ON_GOVERNOR=performance
    OFF_GOVERNOR=ondemand

    if [ "$GUEST_NAME" == "win11" ]; then
      if [ "$OPERATION" == "prepare" ] && [ "$SUB_OPERATION" == "begin" ]; then
        for governor in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
          echo $ON_GOVERNOR > $governor;
        done

        systemctl set-property --runtime -- user.slice AllowedCPUs=$ALLOWED_CPUS
        systemctl set-property --runtime -- system.slice AllowedCPUs=$ALLOWED_CPUS
        systemctl set-property --runtime -- init.scope AllowedCPUs=$ALLOWED_CPUS

        sync
        echo 3 > /proc/sys/vm/drop_caches
        sync
        echo 1 > /proc/sys/vm/compact_memory
      fi

      if [ "$OPERATION" == "release" ] && [ "$SUB_OPERATION" == "end" ]; then
        systemctl set-property --runtime -- user.slice AllowedCPUs=$TOTAL_CPUS
        systemctl set-property --runtime -- system.slice AllowedCPUs=$TOTAL_CPUS
        systemctl set-property --runtime -- init.scope AllowedCPUs=$TOTAL_CPUS

        for governor in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
          echo $OFF_GOVERNOR > $governor;
        done
      fi
    fi
  '';
in {
  zramSwap.enable = true;
  powerManagement.cpuFreqGovernor = "ondemand";
  time.timeZone = "America/Chicago";
  security.rtkit.enable = true;
  fonts.fonts = with pkgs; [ ipafont baekmuk-ttf ];

  systemd.tmpfiles.rules = [
    "L+ /run/gdm/.config/monitors.xml - - - - /etc/nixos/resources/monitors.xml"
    "L+ /var/lib/AccountsService/users/mado - - - - /etc/nixos/resources/gdm"
    "L+ /var/lib/AccountsService/icons/mado - - - - /etc/nixos/resources/avatar.png"
    "L+ /var/lib/libvirt/hooks/qemu - - - - ${qemuHook}"
  ];

  environment = {
    variables = {
      EDITOR = "nano";
      VISUAL = "nano";
    };

    etc = {
#      "wireplumber/alsa.lua.d/51-alsa-monitor.lua".text = ''
#        alsa_monitor.properties = {
#          ["audio.format"] = "S24LE";
#          ["audio.rate"] = 192000;
#          ["api.alsa.period-size"] = 256;
#        };
#      '';

      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
        bluez_monitor.properties = {
          ["bluez5.enable-sbc-xq"] = true,
			    ["bluez5.enable-msbc"] = true,
			    ["bluez5.enable-hw-volume"] = true,
			    ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        };
      '';
    };
  };

  virtualisation = {
    waydroid.enable = true;

    libvirtd = {
      enable = true;
      onBoot = "ignore";
      onShutdown = "shutdown";

      qemu = {
        ovmf.enable = true;
        swtpm.enable = true;

        verbatimConfig = ''
          user = "mado"
          group = "users"
        '';
      };
    };
  };

  hardware = {
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
    bluetooth.enable = true;
    xone.enable = true;
    opengl.driSupport32Bit = true;
  };
}
