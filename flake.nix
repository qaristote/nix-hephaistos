{
  inputs = {
    my-nixpkgs.url = "github:qaristote/my-nixpkgs";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = {
    nixpkgs,
    my-nixpkgs,
    nixos-hardware,
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
        specialArgs = {inherit nixos-hardware;};
        modules =
          commonModules
          ++ [./config];
      };
      hephaistos-test = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = commonModules ++ [./tests/configuration.nix];
      };
    };
  };
}
