{
  nixos-hardware,
  pkgs,
  ...
}:
# usage:
# blankscreen {force, poke}
let
  blankscreen = "echo 0 > /sys/class/backlight/intel_backlight/brightness; setterm -term linux -blank </dev/tty1";
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Community-curated hardware configuration
    nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen # includes intel cpu and ssd
  ];

  personal.hardware = {
    usb.enable = false;
    disks.crypted = "/dev/disk/by-uuid/b7a3424f-d8cd-4985-829c-224bf0f0842a";
    firmwareNonFree.enable = true;
    keyboard.keyMap = "fr";
    sound.enable = false;
  };

  services.logind = {
    # don't suspend on lid close
    lidSwitch = "ignore";
    lidSwitchExternalPower = "ignore";
    lidSwitchDocked = "ignore";
  };

  environment.shellAliases = {inherit blankscreen;};
  systemd = {
    suppressedSystemUnits = ["systemd-backlight@.service"];
    services.blankscreen = {
      description = "Shut down screen";
      path = [pkgs.util-linux];
      script = ''
        ${blankscreen} force
      '';
      wantedBy = ["default.target"];
      after = ["multi-user.target"];
    };
  };

  boot.supportedFilesystems = ["nfs"];
  fileSystems."/data" = {
    device = "ds411.aristote.mesh:/volume2/hephaistos";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };
}
