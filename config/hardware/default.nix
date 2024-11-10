{nixos-hardware, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Community-curated hardware configuration
    nixos-hardware.nixosModules.thinkpad-x1-9th-gen # includes intel cpu and ssd
  ];

  personal.hardware = {
    usb.enable = false;
    disks.crypted = "/dev/disk/by-uuid/18b3e6f0-6ad5-471e-bdf4-e1710d99f13f";
    firmwareNonFree.enable = true;
    keyboard.keyMap = "fr";
    backlights = {
      screen = "intel_backlight";
      keyboard = "dell::kbd_backlight";
    };
    sound.enable = false;
  };
}
