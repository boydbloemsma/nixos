{ lib, ... }: {
    vim = {
        autocomplete = {
            blink-cmp = {
                enable = true;

                mappings = {
                    next = "<C-n>";
                    previous = "<C-p>";
                };
            };
        };

        snippets = {
            luasnip.enable = true;
        };

        visuals = {
            indent-blankline.enable = true;
            fidget-nvim.enable = true;
        };
    };
}
