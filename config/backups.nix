{ lib, pkgs, ... }:
let
  host = "ds218.aristote.mesh";
  path = "/hephaistos";
  sshpass = "${pkgs.sshpass}/bin/sshpass -f /etc/restic/sftp.key";
in
{
  programs.ssh.extraConfig = ''
    Host ${host}
      User hephaistos
      ServerAliveInternal 60
      ServerAliveCountMax 240
  '';

  services.restic.backups.srv = {
    extraOptions = [
      "sftp.command='${sshpass} ssh ${host} -s sftp'"
    ];
    passwordFile = "/etc/restic/srv.key";
    paths = [
      "/srv"
    ];
    repository = "sftp:${host}:${path}";
    timerConfig = {
      OnCalendar = "12:00";
      RandomizedDelaySec = "1h";
      Persistent = true;
    };
    pruneOpts = [ "--keep-daily 7" ];
    initialize = true;
  };
  systemd.services.restic-backups-srv = lib.mkMerge [
    {
      personal.monitor = true;
    }
    (pkgs.lib.personal.services.checkNetwork {
      hosts = [ "ds218.aristote.mesh" ];
      restart = false;
    })
  ];
}
