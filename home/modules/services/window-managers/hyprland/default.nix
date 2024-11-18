{pkgs, ...}: {
  imports = [
    ./config

    # launcher
    ../../../programs/anyrun.nix

    # status bar
    ../../../programs/waybar.nix

    # notifications daemon
    ../../../services/dunst.nix

    # hypr utils
    ../../../services/hypridle.nix
    ../../../services/hyprlock.nix
    ../../../services/hyprpaper.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = with pkgs.hyprlandPlugins; [
      hyprexpo
    ];
    systemd = {
      enable = true;
      variables = ["--all"];
    };
  };

  home.packages = with pkgs; [
    grimblast
    kooha
    libnotify
    slurp
    grim
    swappy
    wf-recorder
    wl-clipboard
    wlr-randr
  ];
}
