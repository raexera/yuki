{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../programs/gtk.nix

    ./config
    ./services/hyprpaper.nix
    ./services/polkit-agent.nix
  ];

  home = {
    packages = with pkgs; [
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
      libnotify
      wf-recorder
      brightnessctl
      pamixer
      slurp
      grim
      hyprpicker
      swappy
      wl-clipboard
      wl-screenrec
      cliphist
      wlr-randr
    ];

    sessionVariables = {
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland,x11";
      XDG_SESSION_TYPE = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
    };
  };

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    systemd.enable = true;
  };
}
