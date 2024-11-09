{
  imports = [
    ../modules/dev
    ../modules/programs/firefox.nix
    ../modules/programs/gpg.nix
    ../modules/programs/gtk.nix
    ../modules/programs/kitty.nix
    ../modules/programs/mpv.nix
    ../modules/programs/obs-studio.nix
    ../modules/programs/playerctld.nix
    ../modules/programs/qt.nix
    ../modules/programs/vscode
    ../modules/programs/xdg.nix
    ../modules/programs/zen.nix
    ../modules/services/blueman-applet.nix
    ../modules/services/gnome-keyring.nix
    ../modules/services/network-manager-applet.nix
    ../modules/services/polkit-agent.nix
    ../modules/services/udiskie.nix
    ../modules/services/window-managers/hyprland
  ];

  wayland.windowManager.hyprland.settings = let
    # Generated using https://gist.github.com/fufexan/e6bcccb7787116b8f9c31160fc8bc543
    accelpoints = "0.000 0.053 0.115 0.189 0.280 0.391 0.525 0.687 0.880 1.108 1.375 1.684 2.040 2.446 2.905 3.422 4.000 4.643 5.355 6.139";
  in {
    monitor = [
      # name, resolution, position, scale
      "eDP-1, preferred, auto, 1.600000"
    ];

    device = {
      name = "pnp0c50:00-06cb:cec0-touchpad";
      accel_profile = "custom ${accelpoints}";
      scroll_points = accelpoints;
      natural_scroll = true;
    };
  };
}
