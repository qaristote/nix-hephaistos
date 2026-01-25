{ lib, pkgs }:

pkgs.stdenvNoCC.mkDerivation {
  name = "repo";
  src = lib.fileset.toSource {
    root = ./src;
    fileset = ./src;
  };
  buildInputs = [ pkgs.bashly ];
  unpackPhase = ''
    ln --symbolic --no-target-directory "$src" src
  '';
  buildPhase = ''
    bashly generate
  '';
  installPhase = ''
    install ./repo "$out"
  '';
}
