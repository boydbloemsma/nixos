{ inputs, ... }: {
  home-manager = {
    extraSpecialArgs = { inherit  inputs; };

    users = {
      "boyd" = {
        imports = [
          ./home.nix
          inputs.self.outputs.homeManagerModules.default
        ];
      };
    };
  };
}
