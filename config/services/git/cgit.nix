{ config, ... }:
{
  services.cgit.default = {
    enable = true;
    scanPath = "/srv/git";
    gitHttpBackend.enable = false;
    nginx = {
      virtualHost = "${config.networking.hostName}.aristote.mesh";
      location = "/git/";
    };
    extraConfig = ''
      root-title=repositories
      root-desc=by Quentin Aristote
    '';
  };

  users.users.cgit.extraGroups = [ "git" ];
}
