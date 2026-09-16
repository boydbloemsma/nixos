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
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      devShells.${system}.shopify = pkgs.mkShell {
        packages = [ pkgs.nodejs_22 ];
        shellHook = ''
          export NPM_CONFIG_PREFIX="$HOME/.npm-global"
          export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"
          if ! command -v shopify &> /dev/null; then
            echo "Installing Shopify CLI..."
            npm install -g @shopify/cli@latest
          fi
        '';
      };

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
            disko.nixModules.disko
            ./hosts/vm-dev/configuration.nix
            ./modules/nixos
          ];
        };
      };

      homeManagerModules.default = ./modules/home-manager;
    };
}
