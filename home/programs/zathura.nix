{
  pkgs,
  lib,
  config,
  ...
}: let
  theme = import ../../theme/theme.nix {};
in {
  programs.zathura = {
    enable = true;
    options = {
      font = "JetBrainsMono Nerd Font 15";

      default-fg = "#${theme.colors.text}";
      default-bg = "#${theme.colors.base}";

      completion-bg = "#${theme.colors.surface0}";
      completion-fg = "#${theme.colors.text}";
      completion-highlight-bg = "#${theme.colors.surface1}";
      completion-highlight-fg = "#${theme.colors.text}";
      completion-group-bg = "#${theme.colors.surface0}";
      completion-group-fg = "#${theme.colors.blue}";

      statusbar-fg = "#${theme.colors.text}";
      statusbar-bg = "#${theme.colors.surface0}";
      statusbar-h-padding = 10;
      statusbar-v-padding = 10;

      notification-bg = "#${theme.colors.surface0}";
      notification-fg = "#${theme.colors.text}";
      notification-error-bg = "#${theme.colors.surface0}";
      notification-error-fg = "#${theme.colors.red}";
      notification-warning-bg = "#${theme.colors.surface0}";
      notification-warning-fg = "#${theme.colors.yellow}";
      selection-notification = true;

      inputbar-fg = "#${theme.colors.text}";
      inputbar-bg = "#${theme.colors.surface0}";

      recolor = true;
      recolor-lightcolor = "#${theme.colors.base}";
      recolor-darkcolor = "#${theme.colors.text}";

      index-fg = "#${theme.colors.text}";
      index-bg = "#${theme.colors.base}";
      index-active-fg = "#${theme.colors.text}";
      index-active-bg = "#${theme.colors.surface0}";

      render-loading-bg = "#${theme.colors.base}";
      render-loading-fg = "#${theme.colors.text}";

      highlight-color = "#${theme.colors.surface1}";
      highlight-active-color = "#${theme.colors.mauve}";
      highlight-fg = "#${theme.colors.mauve}";

      selection-clipboard = "clipboard";
      adjust-open = "best-fit";
      pages-per-row = "1";
      scroll-page-aware = "true";
      scroll-full-overlap = "0.01";
      scroll-step = "100";
      smooth-scroll = true;
      zoom-min = "10";
      guioptions = "none";
    };
  };
}
