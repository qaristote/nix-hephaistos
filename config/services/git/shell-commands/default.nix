{ lib, pkgs, ... }:
let
  repo = import ./repo { inherit lib pkgs; };
  gitShellCommands = "/srv/git/git-shell-commands";
in
{
  system.activationScripts.buildGitShell.text = ''
    install --mode u=rX,g=,o= --owner git --group git --directory ${gitShellCommands}
    rm -rf ${gitShellCommands}/*
    ln -s ${repo} ${gitShellCommands}/repo
  '';
}
