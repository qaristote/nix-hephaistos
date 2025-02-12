{nixos-hardware, ...}: {
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

  # usage:
  # blankscreen {force, poke}
  environment.shellAliases.blankscreen = "echo 0 > /sys/class/backlight/intel_backlight/brightness; setterm -term linux -blank </dev/tty1";
}
