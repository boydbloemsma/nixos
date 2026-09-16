{ lib, ... }: {
    vim.git = {
        gitsigns = {
            enable = true;

            mappings = {
                nextHunk = "]c";
                previousHunk = "[c";
                stageHunk = "<leader>hs";
                resetHunk = "<leader>hr";
                stageBuffer = "<leader>hS";
                undoStageHunk = "<leader>hu";
                resetBuffer = "<leader>hR";
                previewHunk = "<leader>hP";
                diffThis = "<leader>hd";
                toggleDeleted = "<leader>td";
            };

            setupOpts = {
                numhl = true;

                signs = {
                    add.text = "A";
                    change.text = "M";
                    delete.text = "D";
                    topdelete.text = "TD";
                    changedelete.text = "CD";
                    untracked.text = "U";
                };
            };
        };
    };
}
