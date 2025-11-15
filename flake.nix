{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    # use "nixos", or your hostname as the name of the configuration
    # it's a better practice than "default" shown in the video
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/default/configuration.nix
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
    };

    homeManagerModules.default = ./modules/home-manager;

    # Temporary nix develop shell because kamal is not up to date in nix packages
    # When it is up to date, remove the .kamal-gems dir and this code
    devShells.x86_64-linux.kamal = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in pkgs.mkShell {
      buildInputs = with pkgs; [
        ruby
        bundler
        gcc
        gnumake
      ];

      shellHook = ''
          export GEM_HOME="$HOME/.kamal-gems"
          export GEM_PATH="$GEM_HOME"
          export PATH="$GEM_HOME/bin:$PATH"
          unset GEM_ROOT

          if [ ! -f .kamal-gems/bin/kamal ]; then
            echo "Installing Kamal 2.8.2..."
            gem install kamal -v 2.8.2
          fi
      '';
    };
  };
}
