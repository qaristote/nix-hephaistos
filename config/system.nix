{...}: {
  personal.system = {
    flake = "git+file:///etc/nixos/";
    autoUpgrade.enable = true;
  };
  system.autoUpgrade = {
    dates = "12:30";
    allowReboot = true;
  };
}
