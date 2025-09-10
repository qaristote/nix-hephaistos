{ ... }:
{
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
        authProtocols = [ "SAE" ];
        pskRaw = "ext:psk";
      };
    };
  };

  services.resolved = {
    enable = true;
    dnsovertls = "opportunistic";
  };

  services.tailscale = {
    enable = true;
    openFirewall = true;
    disableTaildrop = true;
  };
}
