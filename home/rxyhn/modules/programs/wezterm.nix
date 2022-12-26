{
  config,
  pkgs,
  ...
}: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require("wezterm")

      wezterm.on("format-tab-title",
                 function(tab, tabs, panes, config, hover, max_width)
          local RIGHT_DIVIDER = utf8.char(0xe0bc)

          local active_tab_index = 0
          for _, t in ipairs(tabs) do
              if t.is_active == true then active_tab_index = t.tab_index end
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
              {Background = {Color = s_bg}}, {Foreground = {Color = s_fg}},
              {
                  Text = " " .. tab.tab_index + 1 .. ": " .. tab.active_pane.title ..
                      " "
              }, {Background = {Color = e_bg}}, {Foreground = {Color = e_fg}},
              {Text = RIGHT_DIVIDER}
          }
      end)

      local function font_with_fallback(name, params)
          local names = {name, "emoji"}
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
              {italic = true, font = font_with_fallback(font_name, {italic = true})},
              {
                  italic = true,
                  intensity = "Bold",
                  font = font_with_fallback(font_name, {bold = true, italic = true})
              },
              {
                  intensity = "Bold",
                  font = font_with_fallback(font_name, {bold = true})
              },
              {intensity = "Half", font = font_with_fallback(font_name .. " Light")}
          },
          warn_about_missing_glyphs = false,
          font_size = 10.0,
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
                  action = wezterm.action({
                      SplitHorizontal = {domain = "CurrentPaneDomain"}
                  })
              }, {
                  key = [[\]],
                  mods = "CTRL",
                  action = wezterm.action({
                      SplitVertical = {domain = "CurrentPaneDomain"}
                  })
              }, {
                  key = "q",
                  mods = "CTRL",
                  action = wezterm.action({CloseCurrentPane = {confirm = false}})
              }, {
                  key = "h",
                  mods = "CTRL|SHIFT",
                  action = wezterm.action({ActivatePaneDirection = "Left"})
              }, {
                  key = "l",
                  mods = "CTRL|SHIFT",
                  action = wezterm.action({ActivatePaneDirection = "Right"})
              }, {
                  key = "k",
                  mods = "CTRL|SHIFT",
                  action = wezterm.action({ActivatePaneDirection = "Up"})
              }, {
                  key = "j",
                  mods = "CTRL|SHIFT",
                  action = wezterm.action({ActivatePaneDirection = "Down"})
              }, {
                  key = "h",
                  mods = "CTRL|SHIFT|ALT",
                  action = wezterm.action({AdjustPaneSize = {"Left", 1}})
              }, {
                  key = "l",
                  mods = "CTRL|SHIFT|ALT",
                  action = wezterm.action({AdjustPaneSize = {"Right", 1}})
              }, {
                  key = "k",
                  mods = "CTRL|SHIFT|ALT",
                  action = wezterm.action({AdjustPaneSize = {"Up", 1}})
              }, {
                  key = "j",
                  mods = "CTRL|SHIFT|ALT",
                  action = wezterm.action({AdjustPaneSize = {"Down", 1}})
              }, { -- browser-like bindings for tabbing
                  key = "t",
                  mods = "CTRL",
                  action = wezterm.action({SpawnTab = "CurrentPaneDomain"})
              }, {
                  key = "w",
                  mods = "CTRL",
                  action = wezterm.action({CloseCurrentTab = {confirm = false}})
              }, {
                  key = "Tab",
                  mods = "CTRL",
                  action = wezterm.action({ActivateTabRelative = 1})
              }, {
                  key = "Tab",
                  mods = "CTRL|SHIFT",
                  action = wezterm.action({ActivateTabRelative = -1})
              }, -- standard copy/paste bindings
              {key = "x", mods = "CTRL", action = "ActivateCopyMode"}, {
                  key = "v",
                  mods = "CTRL|SHIFT",
                  action = wezterm.action({PasteFrom = "Clipboard"})
              }, {
                  key = "c",
                  mods = "CTRL|SHIFT",
                  action = wezterm.action({CopyTo = "ClipboardAndPrimarySelection"})
              }
          },

          -- Aesthetic Night Colorscheme
          bold_brightens_ansi_colors = true,
          colors = {
              foreground = "#b6beca",
              background = "#101419",
              cursor_bg = "#b6beca",
              cursor_fg = "#b6beca",
              cursor_border = "#4d5768",
              selection_fg = "#101419",
              selection_bg = "#b6beca",
              scrollbar_thumb = "#b6beca",
              split = "#0e1217",
              ansi = {
                  "#4d5768", "#e05f65", "#78dba9", "#f1cf8a", "#70a5eb", "#c68aee",
                  "#74bee9", "#b6beca"
              },
              brights = {
                  "#485263", "#e5646a", "#94f7c5", "#f6d48f", "#75aaf0", "#cb8ff3",
                  "#79c3ee", "#e3e6eb"
              },
              indexed = {[136] = "#b6beca"},
              tab_bar = {
                  active_tab = {
                      bg_color = "#101419",
                      fg_color = "#b6beca",
                      italic = true
                  },
                  inactive_tab = {bg_color = "#0e1217", fg_color = "#101419"},
                  inactive_tab_hover = {bg_color = "#13171c", fg_color = "#0e1217"},
                  new_tab = {bg_color = "#13171c", fg_color = "#0e1217"},
                  new_tab_hover = {bg_color = "#78dba9", fg_color = "#0e1217"}
              }
          },

          -- Padding
          window_padding = {left = 40, right = 40, top = 40, bottom = 40},

          -- Tab Bar
          enable_tab_bar = true,
          use_fancy_tab_bar = false,
          hide_tab_bar_if_only_one_tab = true,
          show_tab_index_in_tab_bar = false,

          -- General
          automatically_reload_config = true,
          inactive_pane_hsb = {saturation = 1.0, brightness = 1.0},
          window_background_opacity = 0.65,
          window_close_confirmation = "NeverPrompt",
          window_frame = {
              active_titlebar_bg = "#0e1217",
              font = font_with_fallback(font_name, {bold = true})
          }
      }
    '';
  };
}
