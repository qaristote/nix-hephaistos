{...}: {
  personal.networking = {
    enable = true;
    firewall.http = true;
    ssh.enable = true;
  };

  networking = {
    hostName = "hephaistos";
    domain = "local";

    wireless = {
      enable = true;
      environmentFile = "/etc/wpa_supplicant/secrets.env";
      networks.Quentintranet = {
	authProtocols = [ "SAE" ];
        psk = "@PSK@";
      };
    };
  };
}
