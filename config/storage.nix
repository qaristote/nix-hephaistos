{ pkgs, ... }:
{
  boot.supportedFilesystems = [ "nfs" ];
  fileSystems."/backups" = {
    device = "ds411.aristote.mesh:/volume2/hephaistos";
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
  systemd.services.borgbackup-job-srv = {
    personal.monitor = true;
    # Check network connectivity
    path = [ pkgs.unixtools.ping ];
    preStart = "ping -c 1 ds411.aristote.mesh || kill -s SIGUSR1 $$";
    unitConfig = {
      StartLimitIntervalSec = 300;
      StartLimitBurst = 5;
    };
  };
}
