{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = with inputs.self.packages.${pkgs.system}; [
      rofi-emoji-wayland
    ];
    font = "Iosevka Nerd Font 13";
    extraConfig = {
      modi = "drun,run,filebrowser,emoji";
      show-icons = true;
      display-drun = "";
      display-run = "";
      display-filebrowser = "";
      display-emoji = "ﲃ";
      drun-display-format = "{name}";
      window-format = "{w} · {c} · {t}";
    };
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        background = mkLiteral "#303446";
        background-alt = mkLiteral "#414559";
        background-alt-2 = mkLiteral "#51576d";
        foreground = mkLiteral "#c6d0f5";
        selected = mkLiteral "#f4b8e4";
        active = mkLiteral "#838ba7";
        urgent = mkLiteral "#e78284";
      };

      "window" = {
        transparency = "real";
        location = mkLiteral "east";
        anchor = mkLiteral "east";
        fullscreen = false;
        width = mkLiteral "400px";
        height = mkLiteral "100%";
        x-offset = mkLiteral "0px";
        y-offset = mkLiteral "0px";

        enabled = mkLiteral "true";
        border-radius = mkLiteral "0px";
        cursor = "default";
        background-color = mkLiteral "@background";
      };

      "mainbox" = {
        enabled = mkLiteral "true";
        spacing = mkLiteral "0px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = mkLiteral "[inputbar, listbox, mode-switcher]";
      };

      "listbox" = {
        spacing = mkLiteral "15px";
        padding = mkLiteral "15px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = mkLiteral "[message, listview]";
      };

      "inputbar" = {
        enabled = mkLiteral "true";
        spacing = mkLiteral "10px";
        padding = mkLiteral "40px 40px 155px";
        margin = mkLiteral "0 15px";
        border-radius = mkLiteral "0 0 20px 20px";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "@foreground";
        orientation = mkLiteral "horizontal";
        children = mkLiteral "[textbox-prompt-colon, entry]";
      };

      "textbox-prompt-colon" = {
        enabled = mkLiteral "true";
        expand = mkLiteral "false";
        str = " ";
        padding = mkLiteral "15px 18px";
        border-radius = mkLiteral "8px";
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@background";
      };

      "entry" = {
        enabled = mkLiteral "true";
        expand = mkLiteral "true";
        padding = mkLiteral "15px 18px";
        border-radius = mkLiteral "8px";
        background-color = mkLiteral "@background-alt-2";
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
        padding = mkLiteral "15px";
        spacing = mkLiteral "10px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
      };

      "button" = {
        padding = mkLiteral "12px";
        border-radius = mkLiteral "8px";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "pointer";
      };

      "button selected" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@background";
      };

      "listview" = {
        enabled = mkLiteral "true";
        columns = mkLiteral "2";
        lines = "10";
        cycle = mkLiteral "true";
        dynamic = mkLiteral "true";
        scrollbar = mkLiteral "false";
        layout = mkLiteral "vertical";
        reverse = mkLiteral "false";
        fixed-height = mkLiteral "true";
        fixed-columns = mkLiteral "true";

        spacing = mkLiteral "0";
        margin = mkLiteral "40px 0 0 0";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        cursor = "default";
      };

      "element" = {
        enabled = mkLiteral "true";
        orientation = mkLiteral "vertical";
        spacing = mkLiteral "0";
        padding = mkLiteral "20px";
        border-radius = mkLiteral "20px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        cursor = mkLiteral "pointer";
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
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "@selected";
      };

      "element selected.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@foreground";
      };

      "element selected.active" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@foreground";
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
        padding = mkLiteral "12px";
        border-radius = mkLiteral "8px";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "@foreground";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };

      "error-message" = {
        padding = mkLiteral "12px";
        border-radius = mkLiteral "8px";
        background-color = mkLiteral "@background";
        text-color = mkLiteral "@foreground";
      };
    };
  };
}
