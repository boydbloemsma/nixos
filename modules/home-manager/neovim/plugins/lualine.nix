{ lib, ... }: {
    vim.statusline = {
        lualine = {
            enable = true;
            icons.enable = false;
            componentSeparator = {
                left = "|";
                right = "|";
            };
        };
    };
}
