{
  description = "Nixos config flake";

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
      nixpkgs,
      nix-darwin,
      disko,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        zx-1 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/zx-1/configuration.nix
            ./modules/nixos
          ];
        };
        prodesk = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            disko.nixosModules.disko
            ./hosts/prodesk/configuration.nix
            ./modules/nixos
          ];
        };
        t14 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/t14/configuration.nix
            ./modules/nixos
          ];
        };
        vm-dev = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/vm-dev/configuration.nix
            ./modules/nixos
          ];
        };
      };

      darwinConfigurations."boyd" = nix-darwin.lib.darwinSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/mac/configuration.nix
          inputs.home-manager.darwinModules.home-manager
          ./hosts/mac/home-manager.nix
        ];
      };

      homeManagerModules.default = ./modules/home-manager;
    };
}
