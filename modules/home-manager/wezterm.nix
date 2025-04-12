{ config, lib, pkgs, ... }: {
    options.my.wezterm.enable = lib.mkEnableOption "Enable WezTerm with custom config";

    config = lib.mkIf config.my.wezterm.enable {
        programs.wezterm = {
            enable = true;

            extraConfig = ''
                local wezterm = require('wezterm')
                local act = wezterm.action

                local config = {}

                if wezterm.config_builder then
                    config = wezterm.config_builder()
                end

                config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
                config.initial_cols = 128
                config.initial_rows = 32

                config.enable_tab_bar = false
                config.window_close_confirmation = "NeverPrompt"

                config.keys = {
                    {
                        key = 'h',
                        mods = 'CTRL|SHIFT',
                        action = act.ActivatePaneDirection('Left'),
                    },
                    {
                        key = 'l',
                        mods = 'CTRL|SHIFT',
                        action = act.ActivatePaneDirection('Right'),
                    },
                    {
                        key = 'k',
                        mods = 'CTRL|SHIFT',
                        action = act.ActivatePaneDirection('Up'),
                    },
                    {
                        key = 'j',
                        mods = 'CTRL|SHIFT',
                        action = act.ActivatePaneDirection('Down'),
                    },
                    {
                        key = 'D',
                        mods = 'CTRL|SHIFT',
                        action = act.SplitHorizontal,
                    },
                    {
                        key = 'S',
                        mods = 'CTRL|SHIFT',
                        action = act.SplitVertical,
                    },
                    {
                        key = 'RightArrow',
                        mods = 'CTRL|SHIFT',
                        action = act.AdjustPaneSize({ 'Right', 5 }),
                    },
                    {
                        key = 'LeftArrow',
                        mods = 'CTRL|SHIFT',
                        action = act.AdjustPaneSize({ 'Left', 5 }),
                    },
                }

                config.color_scheme = 'Gruvbox light, medium (base16)'

                return config
            '';
        };
    };
}
