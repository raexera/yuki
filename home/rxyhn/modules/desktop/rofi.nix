{
  config,
  pkgs,
  ...
}: let
  power-menu = pkgs.writeShellScriptBin "power-menu" ''
    #!/bin/sh

    shutdown="襤"
    reboot="ﰇ"
    cancel=""

    rofi_cmd() {
      killall rofi || rofi -dmenu -p "Power Menu" -theme power
    }

    run_rofi() {
      echo -e "$shutdown\n$reboot\n$cancel" | rofi_cmd
    }

    case "$(run_rofi)" in
    	$shutdown)
    		systemctl poweroff
    		;;
    	$reboot)
    		systemctl reboot
    		;;
    esac
  '';
in {
  home.packages = with pkgs; [
    (rofi-wayland.override {
      plugins = [rofi-emoji];
    })
    power-menu
    wl-clipboard
    wtype
  ];

  xdg.configFile."rofi/colors.rasi".text = ''
    * {
      background: #181825;
      prompt: #1e1e2e;
      border: #1e1e2e;
      text: #cdd6f4;
      select: #1e1e2e;
    }
  '';

  xdg.configFile."rofi/index.rasi".text = ''
    configuration {
      modi: "drun,emoji";
      display-drun: "Applications";
      drun-display-format: "{name}";
      font: "Inter 13px";
    }

    @import "./colors.rasi"

    * {
      background-color: transparent;
      text-color: @text;
      margin: 0;
      padding: 0;
    }

    window {
      transparency: "real";
      location: center;
      anchor: center;
      fullscreen: false;
      width: 21em;
      x-offset: 0px;
      y-offset: 0px;

      enabled: true;
      border: 2px solid;
      border-color: @border;
      border-radius: 8px;
      background-color: @background;
      cursor: "default";
    }

    inputbar {
      enabled: true;
      border: 0 0 1px 0 solid;
      border-color: @border;
      background-color: @prompt;
      orientation: horizontal;
      children: [ "entry" ];
    }

    entry {
      enabled: true;
      padding: 0.75em 1.25em;
      cursor: text;
      placeholder: "Search application...";
      placeholder-color: @text;
    }

    listview {
      enabled: true;
      columns: 1;
      lines: 6;
      cycle: true;
      dynamic: true;
      scrollbar: false;
      layout: vertical;
      reverse: false;
      fixed-height: true;
      fixed-columns: true;
      margin:  0.5em 0 0.75em;
      cursor: "default";
    }

    element {
      enabled: true;
      margin: 0 0.75em;
      padding: 0.5em 1em;
      cursor: pointer;
      orientation: vertical;
    }

    element normal.normal {
      background-color: inherit;
      text-color: inherit;
    }

    element selected.normal {
      border: 2px solid;
      border-color: @border;
      border-radius: 8px;
      background-color: @select;
    }

    element-text {
      highlight: bold;
      cursor: inherit;
      vertical-align: 0.5;
      horizontal-align: 0.0;
      font: "Inter Medium 13px";
    }
  '';

  xdg.configFile."rofi/emoji.rasi".text = ''
    @theme "index"

    listview {
      columns: 5;
      lines: 4;
      layout: vertical;
      fixed-columns: true;
      margin: 0.5em 0.25em;
      flow: horizontal;
    }

    window {
      width: 19em;
    }

    element {
      padding: 1em;
      margin: 0 0.25em;
    }

    element-text {
      vertical-align: 0.5;
      horizontal-align: 0.5;
    }

    entry {
      placeholder: "Search emoji...";
    }
  '';

  xdg.configFile."rofi/power.rasi".text = ''
    @theme "index"

    * {
      horizontal-align: 0.5;
    }

    window {
      width: 13.5em;
    }

    inputbar {
      children: [ prompt ];
    }

    prompt {
      padding: 0.5em 0.75em;
      font: "Inter 13px";
    }

    listview {
      lines: 3;
      layout: horizontal;
      margin: 0.5em 0.5em 0.75em;
    }

    element {
      padding: 1em 0em;
      margin: 0 0.25em;
      width: 4em;
    }

    element-text {
      font: "monospace Bold 21px";
      vertical-align: 0.5;
      horizontal-align: 0.5;
    }
  '';
}
