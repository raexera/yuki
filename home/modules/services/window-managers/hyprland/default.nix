{
  pkgs,
  inputs,
  ...
}: let
  cursor = "Bibata-Modern-Classic-Hyprcursor";
  cursorPackage = inputs.self.packages.${pkgs.system}.bibata-hyprcursor;
in {
  imports = [
    ./config
    ./scripts

    # launcher
    ./programs/anyrun.nix

    # bar
    ./programs/waybar.nix

    # notifications daemon
    ./services/dunst.nix

    # hypr utils
    ./services/hypridle.nix
    ./services/hyprlock.nix
    ./services/hyprpaper.nix
  ];

  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

    kooha
    libnotify
    slurp
    grim
    swappy
    wf-recorder
    wl-clipboard
    wlr-randr
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
    QT_STYLE_OVERRIDE = "kvantum";
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

  xdg.dataFile."icons/${cursor}".source = "${cursorPackage}/share/icons/${cursor}";
}
