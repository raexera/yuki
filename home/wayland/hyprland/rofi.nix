{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  theme = import ../../../theme/theme.nix {};
in {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    font = "JetBrainsMono Nerd Font 10";
    extraConfig = {
      modi = "drun,run,filebrowser";
      show-icons = true;
      display-drun = "APPS";
      display-run = "RUN";
      display-filebrowser = "FILES";
      drun-display-format = "{name}";
      window-format = "{w} · {c}";
    };
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        background = mkLiteral "#${theme.colors.mantle}";
        background-alt = mkLiteral "#${theme.colors.base}";
        foreground = mkLiteral "#${theme.colors.text}";
        selected = mkLiteral "#${theme.colors.mauve}";
        active = mkLiteral "#${theme.colors.overlay1}";
        urgent = mkLiteral "#${theme.colors.red}";
      };

      "window" = {
        transparency = "real";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        fullscreen = false;
        width = mkLiteral "1000px";
        x-offset = mkLiteral "0px";
        y-offset = mkLiteral "0px";

        enabled = mkLiteral "true";
        border-radius = mkLiteral "12px";
        cursor = "default";
        background-color = mkLiteral "@background";
      };

      "mainbox" = {
        enabled = mkLiteral "true";
        spacing = mkLiteral "0px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = mkLiteral "[\"inputbar\", \"listbox\"]";
      };

      "listbox" = {
        spacing = mkLiteral "20px";
        padding = mkLiteral "20px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = mkLiteral "[\"message\", \"listview\"]";
      };

      "inputbar" = {
        enabled = mkLiteral "true";
        spacing = mkLiteral "10px";
        padding = mkLiteral "100px 60px";
        background-color = mkLiteral "transparent";
        background-image = mkLiteral "url(\"${./assets/launcher/gradient.png}\", width)";
        text-color = mkLiteral "@foreground";
        orientation = mkLiteral "horizontal";
        children = mkLiteral "[\"textbox-prompt-colon\", \"entry\", \"dummy\", \"mode-switcher\"]";
      };

      "textbox-prompt-colon" = {
        enabled = mkLiteral "true";
        expand = mkLiteral "false";
        str = " ";
        padding = mkLiteral "12px 15px";
        border-radius = mkLiteral "100%";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "inherit";
      };

      "entry" = {
        enabled = mkLiteral "true";
        expand = mkLiteral "false";
        width = mkLiteral "300px";
        padding = mkLiteral "12px 16px";
        border-radius = mkLiteral "100%";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "text";
        placeholder = "Search";
        placeholder-color = mkLiteral "inherit";
      };

      "dummy" = {
        expand = mkLiteral "true";
        background-color = mkLiteral "transparent";
      };

      "mode-switcher" = {
        enabled = mkLiteral "true";
        spacing = mkLiteral "10px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
      };

      "button" = {
        width = mkLiteral "80px";
        padding = mkLiteral "12px";
        border-radius = mkLiteral "100%";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "pointer";
      };

      "button selected" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@background-alt";
      };

      "listview" = {
        enabled = mkLiteral "true";
        columns = mkLiteral "6";
        lines = mkLiteral "3";
        cycle = mkLiteral "true";
        dynamic = mkLiteral "true";
        scrollbar = mkLiteral "false";
        layout = mkLiteral "vertical";
        reverse = mkLiteral "false";
        fixed-height = mkLiteral "true";
        fixed-columns = mkLiteral "true";

        spacing = mkLiteral "10px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        cursor = "default";
      };

      "element" = {
        enabled = mkLiteral "true";
        spacing = mkLiteral "10px";
        padding = mkLiteral "10px";
        border-radius = mkLiteral "15px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        cursor = mkLiteral "pointer";
        orientation = mkLiteral "vertical";
      };

      "element normal.normal" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      "element normal.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@foreground";
      };

      "element normal.active" = {
        background-color = mkLiteral "@active";
        text-color = mkLiteral "@foreground";
      };

      "element selected.normal " = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@background";
      };

      "element selected.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@background";
      };

      "element selected.active" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@background";
      };

      "element-icon" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        size = mkLiteral "64px";
        cursor = mkLiteral "inherit";
      };

      "element-text" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.5";
      };

      "message" = {
        background-color = mkLiteral "transparent";
      };

      "textbox" = {
        padding = mkLiteral "15px";
        border-radius = mkLiteral "15px";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "@foreground";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };

      "error-message" = {
        padding = mkLiteral "15px";
        border-radius = mkLiteral "15px";
        background-color = mkLiteral "@background";
        text-color = mkLiteral "@foreground";
      };
    };
  };
}
