{ config, pkgs, ... }:

{
  users.users.git = {
    isSystemUser = true;
    group = "git";
    createHome = true;
    home = "/srv/git";
    shell = "${pkgs.git}/bin/git-shell";
    openssh.authorizedKeys.keys = config.users.users.qaristote.openssh.authorizedKeys.keys ++ [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICT+jPcQhtBu4jxNAn54PV2TJ5krCfFnbXsR3OHk72l8 qaristote@dragonfly-g4"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDh2W0Nv76Nnw8TNysOkxVDZpnW0VEptq4u4Rask6zoO qaristote@optiplex-9030"
    ];
  };

  users.groups.git = { };

  services.openssh = {
    extraConfig = ''
      Match user git
        AllowTcpForwarding no
        AllowAgentForwarding no
        PasswordAuthentication no
        PermitTTY no
        X11Forwarding no
    '';
  };
}
