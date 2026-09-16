{ lib, ... }: {
    vim.telescope = {
        enable = true;

        mappings = {
            findFiles = "<leader>ff";
            buffers = "<leader>fb";
            liveGrep = "<leader>fw";
        };
    };
}
