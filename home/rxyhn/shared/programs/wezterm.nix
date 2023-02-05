{
  config,
  pkgs,
  ...
}: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require "wezterm"

      wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
        local RIGHT_DIVIDER = utf8.char(0xe0bc)

        local active_tab_index = 0
        for _, t in ipairs(tabs) do
          if t.is_active == true then
            active_tab_index = t.tab_index
          end
        end

        local active_bg = config.colors.tab_bar.active_tab.bg_color
        local active_fg = config.colors.tab_bar.active_tab.fg_color
        local inactive_bg = config.colors.tab_bar.inactive_tab.bg_color
        local inactive_fg = config.colors.tab_bar.inactive_tab.fg_color
        local new_tab_bg = config.colors.tab_bar.new_tab.bg_color

        local s_bg, s_fg, e_bg, e_fg

        -- the last tab
        if tab.tab_index == #tabs - 1 then
          if tab.is_active then
            s_bg = active_bg
            s_fg = active_fg
            e_bg = new_tab_bg
            e_fg = active_bg
          else
            s_bg = inactive_bg
            s_fg = inactive_fg
            e_bg = new_tab_bg
            e_fg = inactive_bg
          end
        elseif tab.tab_index == active_tab_index - 1 then
          s_bg = inactive_bg
          s_fg = inactive_fg
          e_bg = active_bg
          e_fg = inactive_bg
        elseif tab.is_active then
          s_bg = active_bg
          s_fg = active_fg
          e_bg = inactive_bg
          e_fg = active_bg
        else
          s_bg = inactive_bg
          s_fg = inactive_fg
          e_bg = inactive_bg
          e_fg = inactive_bg
        end
        return {
          { Background = { Color = s_bg } },
          { Foreground = { Color = s_fg } },
          { Text = " " .. tab.tab_index + 1 .. ": " .. tab.active_pane.title .. " " },
          { Background = { Color = e_bg } },
          { Foreground = { Color = e_fg } },
          { Text = RIGHT_DIVIDER },
        }
      end)

      local mocha_cat = wezterm.color.get_builtin_schemes()["Catppuccin Mocha"]
      mocha_cat.background = "#000000"

      local function font_with_fallback(name, params)
        local names = { name, "emoji" }
        return wezterm.font_with_fallback(names, params)
      end

      local font_name = "monospace"

      return {
        -- OpenGL for GPU acceleration, Software for CPU
        front_end = "OpenGL",

        -- No updates, bleeding edge only
        check_for_updates = false,

        -- Font config
        font = font_with_fallback(font_name),
        font_rules = {
          {
            italic = true,
            font = font_with_fallback(font_name, { italic = true }),
          },
          {
            italic = true,
            intensity = "Bold",
            font = font_with_fallback(font_name, { italic = true, bold = true }),
          },
          {
            intensity = "Bold",
            font = font_with_fallback(font_name, { bold = true }),
          },
        },
        warn_about_missing_glyphs = false,
        font_size = 12.0,
        line_height = 1.0,

        -- Cursor style
        default_cursor_style = "BlinkingUnderline",

        -- X11
        enable_wayland = false,

        -- Keybinds
        disable_default_key_bindings = true,
        keys = {
          {
            key = [[\]],
            mods = "CTRL|ALT",
            action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } },
          },
          {
            key = [[\]],
            mods = "CTRL",
            action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } },
          },
          {
            key = "q",
            mods = "CTRL",
            action = wezterm.action { CloseCurrentPane = { confirm = false } },
          },
          {
            key = "LeftArrow",
            mods = "CTRL|SHIFT",
            action = wezterm.action { ActivatePaneDirection = "Left" },
          },
          {
            key = "RightArrow",
            mods = "CTRL|SHIFT",
            action = wezterm.action { ActivatePaneDirection = "Right" },
          },
          {
            key = "UpArrow",
            mods = "CTRL|SHIFT",
            action = wezterm.action { ActivatePaneDirection = "Up" },
          },
          {
            key = "DownArrow",
            mods = "CTRL|SHIFT",
            action = wezterm.action { ActivatePaneDirection = "Down" },
          },
          {
            key = "LeftArrow",
            mods = "CTRL|SHIFT|ALT",
            action = wezterm.action { AdjustPaneSize = { "Left", 1 } },
          },
          {
            key = "RightArrow",
            mods = "CTRL|SHIFT|ALT",
            action = wezterm.action { AdjustPaneSize = { "Right", 1 } },
          },
          {
            key = "UpArrow",
            mods = "CTRL|SHIFT|ALT",
            action = wezterm.action { AdjustPaneSize = { "Up", 1 } },
          },
          {
            key = "DownArrow",
            mods = "CTRL|SHIFT|ALT",
            action = wezterm.action { AdjustPaneSize = { "Down", 1 } },
          },
          { -- browser-like bindings for tabbing
            key = "t",
            mods = "CTRL",
            action = wezterm.action { SpawnTab = "CurrentPaneDomain" },
          },
          {
            key = "w",
            mods = "CTRL",
            action = wezterm.action { CloseCurrentTab = { confirm = false } },
          },
          {
            key = "Tab",
            mods = "CTRL",
            action = wezterm.action { ActivateTabRelative = 1 },
          },
          {
            key = "Tab",
            mods = "CTRL|SHIFT",
            action = wezterm.action { ActivateTabRelative = -1 },
          }, -- standard copy/paste bindings
          { key = "x", mods = "CTRL", action = "ActivateCopyMode" },
          {
            key = "v",
            mods = "CTRL|SHIFT",
            action = wezterm.action { PasteFrom = "Clipboard" },
          },
          {
            key = "c",
            mods = "CTRL|SHIFT",
            action = wezterm.action { CopyTo = "ClipboardAndPrimarySelection" },
          },
        },

        -- Colorschemes
        bold_brightens_ansi_colors = true,
        color_schemes = { ["MochaCat"] = mocha_cat },
        color_scheme = "MochaCat",

        -- Padding
        window_padding = { left = 40, right = 40, top = 40, bottom = 40 },

        -- Tab Bar
        enable_tab_bar = true,
        use_fancy_tab_bar = false,
        hide_tab_bar_if_only_one_tab = true,
        show_tab_index_in_tab_bar = false,

        -- General
        automatically_reload_config = true,
        inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
        window_background_opacity = 0.4,
        window_close_confirmation = "NeverPrompt",
      }
    '';
  };
}
