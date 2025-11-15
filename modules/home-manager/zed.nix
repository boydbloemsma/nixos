{ config, lib, pkgs, ... }: {
  options.zed.enable = lib.mkEnableOption "Enable Zed with custom config";

  config = lib.mkIf config.zed.enable {
    programs.zed-editor = {
      enable = true;

      extensions = [ "nix" "toml" "yaml" "php" ];

      userSettings = {
        theme = {
          mode = "system";
          dark = "One Dark";
          light = "One Light";
        };

        vim_mode = true;

        show_edit_predictions = false;

        languages = {
          "PHP" = {
            language_servers = [ "intelephense" "!phpactor" "..." ];
          };
        };

        diagnostics = {
          inline = {
            enabled = false;
          };
        };

        relative_line_numbers = true;
        vertical_scroll_margin = 5;

        command_aliases = {
          "W" = "w";
        };

        ui_font_size = 16;
        buffer_font_size = 16;
        buffer_font_features = {
          calt = false;
        };

        git = {
          inline_blame = {
            enabled = false;
          };
        };
      };

      userKeymaps = [
        {
          context = "Workspace";
          bindings = {
            "shift shift" = "file_finder::Toggle";
            "ctrl-shift-g" = [
              "task::Spawn"
              {
                task_name = "LazyGit";
                reveal_target = "center";
              }
            ];
          };
        }
        {
          context = "VimControl && !menu";
          bindings = {
            "] c" = "editor::GoToHunk";
            "[ c" = "editor::GoToPreviousHunk";
          };
        }
      ];

      userTasks = [
        {
          label = "LazyGit";
          command = "lazygit";
          shell = {
            program = "sh";
          };
          hide = "on_success";
          reveal_target = "center";
          show_summary = false;
          show_command = false;
          allow_concurrent_runs = true;
          use_new_terminal = true;
        }
      ];
    };
  };
}
