{
  inputs = {
    my-nixpkgs.url = "github:qaristote/my-nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.05";
  };

  outputs = {
    nixpkgs,
    my-nixpkgs,
    ...
  }: {
    nixosConfigurations = let
      system = "x86_64-linux";
      commonModules = [
        my-nixpkgs.nixosModules.personal
        ({...}: {
          nixpkgs.overlays = [
            my-nixpkgs.overlays.personal
          ];
        })
      ];
    in {
      hephaistos = nixpkgs.lib.nixosSystem {
        inherit system;
        modules =
          commonModules
          ++ [./config ./config/hardware-configuration.nix];
      };
      hephaistos-test = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules ++ [./tests/configuration.nix];
      };
    };
  };
}
