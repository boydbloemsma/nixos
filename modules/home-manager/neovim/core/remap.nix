{ lib, ... }: {
    vim.keymaps = [
        # netrw
        {
            mode = "n";
            key = "<leader>pv";
            action = "vim.cmd.Ex";
            lua = true;
        }

        # window navigation
        {
            mode = "n";
            key = "<C-h>";
            action = "<C-w><C-h>";
        }
        {
            mode = "n";
            key = "<C-j>";
            action = "<C-w><C-j>";
        }
        {
            mode = "n";
            key = "<C-k>";
            action = "<C-w><C-k>";
        }
        {
            mode = "n";
            key = "<C-l>";
            action = "<C-w><C-l>";
        }

        # window resizing
        {
            mode = "n";
            key = "<C-Up>";
            action = ":resize +2<CR>";
        }
        {
            mode = "n";
            key = "<C-Down>";
            action = ":resize -2<CR>";
        }
        {
            mode = "n";
            key = "<C-Left>";
            action = ":vertical resize +2<CR>";
        }
        {
            mode = "n";
            key = "<C-Right>";
            action = ":vertical resize -2<CR>";
        }

        # terminal mode
        {
            mode = "t";
            key = "<esc>";
            action = "<C-\\><C-n>";
        }
        {
            mode = "t";
            key = "<C-h>";
            action = "<Cmd>wincmd h<CR>";
        }
        {
            mode = "t";
            key = "<C-j>";
            action = "<Cmd>wincmd j<CR>";
        }
        {
            mode = "t";
            key = "<C-k>";
            action = "<Cmd>wincmd k<CR>";
        }
        {
            mode = "t";
            key = "<C-l>";
            action = "<Cmd>wincmd l<CR>";
        }

        # command mode
        {
          mode = "c";
          key = "Q";
          action = "q";
        }
        {
          mode = "c";
          key = "W";
          action = "w";
        }
    ];
}
