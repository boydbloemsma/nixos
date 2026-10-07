{ lib, ... }: {
    vim = {
        utility.undotree.enable = true;

        keymaps = [
            {
                mode = "n";
                key = "<leader>u";
                action = "<Cmd>UndotreeToggle<CR>";
            }
        ];
    };
}
