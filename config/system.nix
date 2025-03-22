{...}: {
  personal.system = {
    flake = "git+file:///etc/nixos/";
    autoUpgrade.enable = true;
  };
}
