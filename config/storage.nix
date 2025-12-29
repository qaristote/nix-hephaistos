{ lib, pkgs, ... }:
{
  boot.supportedFilesystems = [ "nfs" ];
  fileSystems."/backups" = {
    device = "ds218.aristote.mesh:/volume1/hephaistos";
    fsType = "nfs";
    options = [
      # lazy mounting
      "x-systemd.automount"
      "noauto"
      # sleeping
      "x-systemd.idle-timeout=600"
    ];
  };

  services.borgbackup.jobs.srv = {
    paths = "/srv";
    exclude = [ ];
    repo = "/backups/srv";
    doInit = false;
    encryption = {
      mode = "repokey";
      passCommand = "cat /etc/borg/passphrase";
    };
    compression = "auto,lzma";
    startAt = "daily";
    prune.keep.daily = 7;
  };
  systemd.services.borgbackup-job-srv = lib.mkMerge [
    {
      personal.monitor = true;
    }
    (pkgs.lib.personal.services.checkNetwork {
      hosts = [ "ds218.aristote.mesh" ];
      restart = false;
    })
  ];
}
