## FAQ
# - Why backups?
# A shared directory with caching would require the NFS server to be up, and
# wouldn't have the remote directory be encrypted. Plus NFS doesn't work.
# - Why Restic?
# Borg would be more efficient, but, as of writing this (01-2026), it doesn't
# support sftp and the NAS doesn't support non-admin SSH. When Borg v2 is out I
# can switch.

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
      ServerAliveInterval 60
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
      # the NAS is on between 10pm and 6am
      OnCalendar = "23:00";
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
