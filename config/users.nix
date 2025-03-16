{pkgs, ...}: {
  personal.user.enable = true;
  users = {
    users = {
      nixremote = {
        isSystemUser = true;
        shell = pkgs.busybox-sandbox-shell;
        group = "nixremote";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEgohiYF2Dsaq6ImGaslnKJMwpiVtwAaM9cm1tpSRr7t root@kerberos"
        ];
      };
      hermes = {
        isNormalUser = true;
        shell = pkgs.busybox-sandbox-shell;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGstvYymapGvkjvKbFqkMZtE9ft9uEM13n8q798HtOT+ root@hermes"
        ];
        homeMode = "700";
      };
    };
    groups.nixremote = {};
  };

  system.userActivationScripts.hermesSetup = ''
    if [ $(whoami) = hermes ]
    then
      mkdir --parents --mode=700 nixos-configuration
      git init --bare nixos-configuration
    fi
  '';
}
