{...}: {
  boot.supportedFilesystems = ["nfs"];
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

  services.restic.backups = {};
}
