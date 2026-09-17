{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
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

    llm-agents-nix = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    theme-bobthefish = {
      url = "github:oh-my-fish/theme-bobthefish";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      disko,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        t480 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/t480/configuration.nix
            ./modules/nixos
          ];
        };
        zx-1 = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/zx-1/configuration.nix
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
            disko.nixosModules.disko
            ./hosts/vm-dev/configuration.nix
            ./modules/nixos
          ];
        };
      };

      homeManagerModules.default = ./modules/home-manager;

      devShells."x86_64-linux" = {
        php85 = nixpkgs.legacyPackages."x86_64-linux".mkShell {
            packages = with nixpkgs.legacyPackages."x86_64-linux"; [
                php85
                php85Packages.composer
                laravel
            ];
        };
      };
    };
}
