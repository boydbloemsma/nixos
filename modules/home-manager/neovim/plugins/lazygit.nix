{ lib, ... }: {
    vim = {
        terminal = {
            toggleterm = {
                enable = true;

                mappings.open = "<C-t>";

                lazygit = {
                    enable = true;

                    mappings.open = "<leader>lg";
                };
            };
        };
    };
}
