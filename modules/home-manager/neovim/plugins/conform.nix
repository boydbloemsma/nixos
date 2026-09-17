{ lib, ... }: {
  vim.formatter = {
    conform-nvim = {
      enable = true;

      presets = {
        prettier.enable = true;
        php-cs-fixer.enable = true;
        nixfmt-rs.enable = true;
      };

      setupOpts = {
        formatters_by_ft = {
          lua = [ "stylua" ];
          nix = [ "nixfmt-rs" ];
          php = [ "php-cs-fixer" ];
        };
      };
    };
  };
}
