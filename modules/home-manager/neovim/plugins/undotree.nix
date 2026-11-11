{ ... }: {
  vim = {
    utility.undotree.enable = true;
    undoFile.enable = true;

    keymaps = [
      {
        mode = "n";
        key = "<leader>u";
        action = "<Cmd>UndotreeToggle<CR>";
      }
    ];
  };
}
