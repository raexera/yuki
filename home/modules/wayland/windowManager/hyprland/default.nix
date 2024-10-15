{
  config,
  inputs,
  pkgs,
  ...
}: let
  cursor = "Bibata-Modern-Classic-Hyprcursor";
  cursorPackage = inputs.self.packages.${pkgs.system}.bibata-hyprcursor;
in {
  imports = [
    ./config

    ./programs/anyrun
    ./programs/waybar

    # notifications daemon
    ./services/dunst.nix

    # hypr utils
    ./services/hypridle.nix
    ./services/hyprlock.nix
    ./services/hyprpaper.nix
  ];

  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    inputs.self.packages.${pkgs.system}.wl-ocr
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
