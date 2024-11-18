{lib, modulesPath, ...}: {
  imports = [
    # (modulesPath + "/profiles/headless.nix")
    (modulesPath + "/profiles/minimal.nix")
    ./boot.nix
    ./environment.nix
    ./hardware
    ./networking.nix
    ./nix.nix
    ./services
    ./users.nix
  ];

  # needed so that the server doesn't rebuild big packages
  # originally enabled in modulesPath + profiles/minimal.nix
  environment.noXlibs = false;

  # re-enable console
  # disabled by headless profile
  # systemd.services."getty@tty1".enable = lib.mkForce true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
