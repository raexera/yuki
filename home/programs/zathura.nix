{
  pkgs,
  lib,
  config,
  theme,
  ...
}: {
  programs.zathura = {
    enable = true;
    options = {
      font = "JetBrainsMono Nerd Font 15";

      default-fg = theme.xcolors.text;
      default-bg = theme.xcolors.base;

      completion-bg = theme.xcolors.surface0;
      completion-fg = theme.xcolors.text;
      completion-highlight-bg = theme.xcolors.surface1;
      completion-highlight-fg = theme.xcolors.text;
      completion-group-bg = theme.xcolors.surface0;
      completion-group-fg = theme.xcolors.blue;

      statusbar-fg = theme.xcolors.text;
      statusbar-bg = theme.xcolors.surface0;
      statusbar-h-padding = 10;
      statusbar-v-padding = 10;

      notification-bg = theme.xcolors.surface0;
      notification-fg = theme.xcolors.text;
      notification-error-bg = theme.xcolors.surface0;
      notification-error-fg = theme.xcolors.red;
      notification-warning-bg = theme.xcolors.surface0;
      notification-warning-fg = theme.xcolors.yellow;
      selection-notification = true;

      inputbar-fg = theme.xcolors.text;
      inputbar-bg = theme.xcolors.surface0;

      recolor = true;
      recolor-lightcolor = theme.xcolors.base;
      recolor-darkcolor = theme.xcolors.text;

      index-fg = theme.xcolors.text;
      index-bg = theme.xcolors.base;
      index-active-fg = theme.xcolors.text;
      index-active-bg = theme.xcolors.surface0;

      render-loading-bg = theme.xcolors.base;
      render-loading-fg = theme.xcolors.text;

      highlight-color = theme.xcolors.surface1;
      highlight-active-color = theme.xcolors.mauve;
      highlight-fg = theme.xcolors.mauve;

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
