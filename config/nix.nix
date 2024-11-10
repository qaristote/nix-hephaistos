{...}: {
  personal.nix = {
    enable = true;
    autoUpgrade = {
      enable = true;
      autoUpdateInputs = ["nixpkgs"];
    };
    gc.enable = true;
    flake = "git+file:///etc/nixos/";
  };
  nix.settings.max-jobs = "???";
  nixpkgs.flake = {
    setNixPath = true;
    setFlakeRegistry = true;
  };
}
