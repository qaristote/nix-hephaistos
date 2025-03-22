{
  lib,
  pkgs,
  ...
}: let
  remoteBuildingUsers = {
    hermes = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGstvYymapGvkjvKbFqkMZtE9ft9uEM13n8q798HtOT+ root@hermes";
    kerberos = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgohiYF2Dsaq6ImGaslnKJMwpiVtwAaM9cm1tpSRr7t root@kerberos";
  };
in {
  personal.user.enable = true;
  users.users =
    builtins.mapAttrs (_: key: {
      isNormalUser = true;
      shell = pkgs.busybox-sandbox-shell;
      openssh.authorizedKeys.keys = [key];
      homeMode = "700";
    })
    remoteBuildingUsers;

  system.userActivationScripts.remoteBuildingSetup = ''
    if [[ $(whoami) = @(${lib.concatStringsSep "|" (builtins.attrNames remoteBuildingUsers)}) ]]
    then
      mkdir --parents --mode=700 nixos-configuration
      git init --bare nixos-configuration
    fi
  '';
}
