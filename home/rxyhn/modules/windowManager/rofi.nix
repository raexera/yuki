{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;

    extraConfig = {
      modi = "drun";
      show-icons = true;
      display-drun = " ";
      drun-display-format = "{name}";
    };

    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        font = "Inter 10";
        foreground = mkLiteral "#FFFFFFFF";
      };

      "window" = {
        transparency = "real";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        fullscreen = true;
        width = mkLiteral "100%";
        height = mkLiteral "100%";
        x-offset = mkLiteral "0px";
        y-offset = mkLiteral "0px";

        enabled = true;
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        background-color = mkLiteral "black / 10%";
        cursor = "default";
      };

      "mainbox" = {
        enabled = true;
        spacing = mkLiteral "100px";
        margin = mkLiteral "0px";
        padding = mkLiteral "100px 225px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        background-color = mkLiteral "transparent";
        children = mkLiteral "[inputbar, listview]";
      };

      "inputbar" = {
        enabled = true;
        spacing = mkLiteral "10px";
        margin = mkLiteral "0% 25%";
        padding = mkLiteral "18px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "12px";
        background-color = mkLiteral "white / 5%";
        text-color = mkLiteral "@foreground";
        children = mkLiteral "[prompt, entry]";
      };

      "prompt" = {
        enabled = true;
        font = "monospace 10";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };

      "textbox-prompt-colon" = {
        enabled = true;
        expand = false;
        str = "::";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };

      "entry" = {
        enabled = true;
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "text";
        placeholder = "Type to search...";
        placeholder-color = mkLiteral "inherit";
      };

      "listview" = {
        enabled = true;
        columns = 8;
        lines = 4;
        cycle = true;
        dynamic = true;
        scrollbar = false;
        layout = mkLiteral "vertical";
        reverse = false;
        fixed-height = true;
        fixed-columns = true;

        spacing = mkLiteral "0px";
        margin = mkLiteral "0px";
        padding = mkLiteral "0px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        cursor = "default";
      };

      "element" = {
        enabled = true;
        spacing = mkLiteral "15px";
        margin = mkLiteral "0px";
        padding = mkLiteral "35px 10px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "15px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        orientation = mkLiteral "vertical";
        cursor = mkLiteral "pointer";
      };

      "element normal.normal" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
      };

      "element selected.normal" = {
        background-color = mkLiteral "white / 5%";
        text-color = mkLiteral "@foreground";
      };

      "element-icon" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        size = mkLiteral "128px";
        cursor = mkLiteral "inherit";
      };

      "element-text" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        highlight = mkLiteral "bold";
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.5";
      };

      "error-message" = {
        padding = mkLiteral "100px";
        border = mkLiteral "0px solid";
        border-radius = mkLiteral "0px";
        background-color = mkLiteral "black / 10%";
        text-color = mkLiteral "@foreground";
      };

      "textbox" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
        highlight = mkLiteral "none";
      };
    };
  };
}
