{
  config,
  ...
}:
let
  realm = "aristote.mesh";
in
{
  # client
  security.krb5 = {
    enable = true;
    settings = {
      libdefaults.default_realm = realm;
      realms."${realm}" =
        let
          server = "${config.networking.hostName}.${realm}";
        in
        {
          kdc = server;
          admin_server = server;
        };
    };
  };

  # server
  networking.firewall.allowedTCPPorts = [
    88
    749
  ];
  services.kerberos_server = {
    enable = true;
    settings.realms."${realm}" = { };
    # initialization procedure
    # https://github.com/NixOS/nixpkgs/issues/72722#issuecomment-557658883
    # > kdb5_util create -s -r ${realm}
    # > systemctl restart kadmind.service kdc.service
  };

}
