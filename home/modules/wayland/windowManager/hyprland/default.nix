{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  _ = lib.getExe;

  # OCR (Optical Character Recognition) utility
  ocrScript = let
    inherit (pkgs) grim libnotify slurp tesseract5 wl-clipboard;
  in
    pkgs.writeShellScriptBin "wl-ocr" ''
      ${_ grim} -g "$(${_ slurp})" -t ppm - | ${_ tesseract5} - - | ${wl-clipboard}/bin/wl-copy
      ${_ libnotify} "$(${wl-clipboard}/bin/wl-paste)"
    '';

  # Volume control utility
  volumectl = let
    inherit (pkgs) libnotify pamixer libcanberra-gtk3;
  in
    pkgs.writeShellScriptBin "volumectl" ''
      #!/usr/bin/env bash

      case "$1" in
      up)
        ${_ pamixer} -i "$2"
        ;;
      down)
        ${_ pamixer} -d "$2"
        ;;
      toggle-mute)
        ${_ pamixer} -t
        ;;
      esac

      volume_percentage="$(${_ pamixer} --get-volume)"
      isMuted="$(${_ pamixer} --get-mute)"

      if [ "$isMuted" = "true" ]; then
        ${libnotify}/bin/notify-send --transient \
          -u normal \
          -a "VOLUMECTL" \
          -i audio-volume-muted-symbolic \
          "VOLUMECTL" "Volume Muted"
      else
        ${libnotify}/bin/notify-send --transient \
          -u normal \
          -a "VOLUMECTL" \
          -h string:x-canonical-private-synchronous:volumectl \
          -h int:value:"$volume_percentage" \
          -i audio-volume-high-symbolic \
          "VOLUMECTL" "Volume: $volume_percentage%"

        ${libcanberra-gtk3}/bin/canberra-gtk-play -i audio-volume-change -d "volumectl"
      fi
    '';

  # Brightness control utility
  lightctl = let
    inherit (pkgs) libnotify brightnessctl;
  in
    pkgs.writeShellScriptBin "lightctl" ''
      case "$1" in
      up)
        ${_ brightnessctl} -q s +"$2"%
        ;;
      down)
        ${_ brightnessctl} -q s "$2"%-
        ;;
      esac

      brightness_percentage=$((($(${_ brightnessctl} g) * 100) / $(${_ brightnessctl} m)))
      ${libnotify}/bin/notify-send --transient \
        -u normal \
        -a "LIGHTCTL" \
        -h string:x-canonical-private-synchronous:lightctl \
        -h int:value:"$brightness_percentage" \
        -i display-brightness-symbolic \
        "LIGHTCTL" "Brightness: $brightness_percentage%"
    '';

  cursor = "Bibata-Modern-Classic-Hyprcursor";
  cursorPackage = inputs.self.packages.${pkgs.system}.bibata-hyprcursor;
in {
  imports = [
    ./anyrun
    ./config
    ./waybar

    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    config.wayland.windowManager.hyprland.package

    dbus
    libnotify
    wf-recorder
    slurp
    glib
    grim
    gtk3
    hyprpicker
    swappy
    wl-clipboard
    wl-screenrec
    wlr-randr
    xdg-utils
    ydotool

    # Custom Utilities
    ocrScript
    volumectl
    lightctl
  ];

  home.sessionVariables = {
    # toolkit backend
    GDK_BACKEND = "wayland,x11,*";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";

    # XDG
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";

    # QT
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    # firefox
    MOZ_ENABLE_WAYLAND = "1";
  };

  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.system}.default;

    systemd = {
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };
  };

  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";
    mimeApps.enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  xdg.dataFile."icons/${cursor}".source = "${cursorPackage}/share/icons/${cursor}";
}
