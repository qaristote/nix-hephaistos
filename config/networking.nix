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
      secretsFile = "/etc/wpa_supplicant/secrets";
      networks.Quentintranet = {
        authProtocols = ["SAE"];
        pskRaw = "ext:psk";
      };
    };

    firewall.allowedUDPPorts = [51820];
    wireguard = {
      enable = true;
      interfaces.talaria = {
        ips = ["10.13.42.2/24"];
        listenPort = 51820;
        privateKeyFile = "/etc/wireguard/talaria.key";
        peers = [
          {
            publicKey = "qgDFtt7qlKXW81bKpGHg793OXKPM4Hfjg9ntQrANXio=";
            allowedIPs = ["10.13.42.1"];
            endpoint = "hermes.aristote.fr:51820";
            persistentKeepalive = 25;
          }
        ];
      };
    };
  };

  services.tailscale = {
    enable = true;
    openFirewall = true;
    disableTaildrop = true;
  };
}
