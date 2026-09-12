{
  description = "Tamerlan's nix-darwin + home-manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      nixpkgs,
      nix-darwin,
      home-manager,
      ...
    }:
    let
      system = "aarch64-darwin";
      user = "tamerlan";
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;

      darwinConfigurations."mac" = nix-darwin.lib.darwinSystem {
        inherit system;

        specialArgs = {
          inherit inputs user;
        };

        modules = [
          ./nix/darwin.nix

          home-manager.darwinModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "hm-backup";
            home-manager.extraSpecialArgs = {
              inherit user;
            };
            home-manager.users.${user} = import ./nix/home.nix;
          }
        ];
      };
    };
}
