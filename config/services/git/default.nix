{ config, pkgs, ... }:

{
  users.users.git = {
    isSystemUser = true;
    group = "git";
    createHome = true;
    home = "/srv/git";
    shell = "${pkgs.git}/bin/git-shell";
    openssh.authorizedKeys.keys = with config.personal.lib.publicKeys.ssh; [
      latitude-7490
      precision-3571
      dragonfly-g4
      optiplex-9030
    ];
  };

  users.groups.git = { };
}
