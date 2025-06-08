{...}: {
  boot.supportedFilesystems = ["nfs"];
  fileSystems."/data" = {
    device = "ds411.aristote.mesh:/volume2/hephaistos";
    fsType = "nfs";
    options = [
      # lazy mounting
      "x-systemd.automount"
      "noauto"
      # sleeping
      "x-systemd.idle-timeout=600"
      # caching
      "fsc"
    ];
  };

  services.cachefilesd.enable = true;
}
