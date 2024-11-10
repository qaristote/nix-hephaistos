{...}: {
  personal.networking = {
    enable = true;
    firewall.http = true;
    ssh.enable = true;
  };

  networking = {
    hostName = "hephaistos";
    domain = "local";

    useDHCP = false;
    interfaces."???".useDHCP = true;
  };
}
