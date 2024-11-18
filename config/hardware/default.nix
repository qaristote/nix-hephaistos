{nixos-hardware, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Community-curated hardware configuration
    nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen # includes intel cpu and ssd
  ];

  personal.hardware = {
    usb.enable = false;
    disks.crypted = "/dev/disk/by-uuid/edfa1320-68eb-4439-bef0-226a83c05376";
    firmwareNonFree.enable = true;
    keyboard.keyMap = "fr";
    sound.enable = false;
  };
}

