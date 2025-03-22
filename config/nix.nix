{...}: {
  personal.nix = {
    enable = true;
    gc.enable = true;
  };
  nix.settings.max-jobs = 4;
  nixpkgs.flake = {
    setNixPath = true;
    setFlakeRegistry = true;
  };
}
