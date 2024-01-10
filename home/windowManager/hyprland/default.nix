{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../programs/gtk.nix

    ./config
    ./programs/swaylock.nix
    ./programs/waybar.nix
    ./programs/wofi.nix

    ./services/cliphist.nix
    ./services/dunst.nix
    ./services/swaybg.nix
    ./services/swayidle.nix
  ];

  home = {
    packages = with pkgs; [
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
      config.wayland.windowManager.hyprland.package

      cliphist
      dbus
      libnotify
      libcanberra-gtk3
      wf-recorder
      brightnessctl
      pamixer
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

    sessionVariables = {
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    systemd = {
      enable = true;
      extraCommands = lib.mkBefore [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };

    xwayland.enable = true;
  };

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
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
}
