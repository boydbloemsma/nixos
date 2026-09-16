{ lib, ... }: {
    vim.statusline = {
        lualine = {
            enable = true;
            setupOpts = {
                options = {
                    icons_enabled = true;
                    components_separators = {
                        left = "|";
                        right = "|";
                    };
                };
            };
        };
    };
}
