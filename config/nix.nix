{...}: {
  personal.nix = {
    enable = true;
    autoUpgrade.enable = true;
    gc.enable = true;
    flake = "git+file:///etc/nixos/";
  };
  nix.settings.max-jobs = 4;
  nixpkgs.flake = {
    setNixPath = true;
    setFlakeRegistry = true;
  };
  system.autoUpgrade.dates = "12:30";
}
