{ pkgs, lib, ... }: 
{
    vim = {
        telescope = {
            enable = true;

            mappings = {
                findFiles = "<leader>ff";
                buffers = "<leader>fb";
                liveGrep = "<leader>fw";
                resume = "<leader>fr";
            };

            extensions = [
                {
                    name = "fzf";
                    packages = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];
                    setup.fzf.fuzzy = true;
                }
            ];
        };

        keymaps = [
            {
                key = "<leader>/";
                mode = "n";
                lua = true;
                action = "require('telescope.builtin').current_buffer_fuzzy_find";
                desc = "Search in buffer";
            }
        ];
    };
}
