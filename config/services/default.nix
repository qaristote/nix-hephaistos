{ config, ... }:

{
  imports = [ ./git ];

  services.nginx.virtualHosts."${config.networking.hostName}.aristote.mesh".locations."/".extraConfig =
    ''
      return 444;
    '';
}
