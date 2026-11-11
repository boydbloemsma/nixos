{
  description = "NixOS and nix-darwin configs";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    llm-agents-nix.url = "github:numtide/llm-agents.nix";

    theme-bobthefish = {
      url = "github:oh-my-fish/theme-bobthefish";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      disko,
      ...
    }@inputs:
    let
      # Home Manager wiring shared by every host; the user's config lives in
      # hosts/<host>/home.nix on top of our home-manager modules.
      homeManager = user: host: {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = { inherit inputs; };
          backupFileExtension = "backup";
          users.${user}.imports = [
            ./hosts/${host}/home.nix
            self.homeManagerModules.default
          ];
        };
      };

      mkNixos =
        host:
        {
          withHome ? true,
          modules ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/${host}/configuration.nix
            ./modules/nixos
          ]
          ++ nixpkgs.lib.optionals withHome [
            home-manager.nixosModules.default
            (homeManager "boyd" host)
          ]
          ++ modules;
        };
    in
    {
      nixosConfigurations = {
        t14 = mkNixos "t14" { };
        zx-1 = mkNixos "zx-1" { };
        vm-dev = mkNixos "vm-dev" { };
        prodesk = mkNixos "prodesk" {
          withHome = false;
          modules = [ disko.nixosModules.disko ];
        };
      };

      darwinConfigurations.boyd = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/mac/configuration.nix
          home-manager.darwinModules.home-manager
          (homeManager "ede-mac048" "mac")
        ];
      };

      homeManagerModules.default = ./modules/home-manager;
    };
}
