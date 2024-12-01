{pkgs, ...}: {
  personal.user.enable = true;
  users = {
    users."nixremote" = {
      isSystemUser = true;
      shell = pkgs.busybox-sandbox-shell;
      group = "nixremote";
      openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgohiYF2Dsaq6ImGaslnKJMwpiVtwAaM9cm1tpSRr7t root@kerberos"];
    };
    groups.nixremote = {};
  };
  nix.settings.trusted-users = ["nixremote"];
}
