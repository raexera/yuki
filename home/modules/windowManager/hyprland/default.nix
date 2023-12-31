{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  mkService = lib.recursiveUpdate {
    Unit.PartOf = ["graphical-session.target"];
    Unit.After = ["graphical-session.target"];
    Install.WantedBy = ["graphical-session.target"];
  };
in {
  imports = [
    ../../programs/gtk.nix

    ./config
    ./programs/swaylock.nix
    ./services/dunst.nix
    # ./services/hyprpaper.nix
    ./services/polkit-agent.nix
    ./services/swayidle.nix
  ];

  home = {
    packages = with pkgs; [
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
      config.wayland.windowManager.hyprland.package
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

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default;
    systemd.enable = true;
  };

  systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["hyprland-session.target"];

  systemd.user.services = {
    swaybg = mkService {
      Unit.Description = "Wallpaper chooser";
      Service = {
        ExecStart = "${lib.getExe pkgs.swaybg} -m fill -i ${./assets/wallpaper.png}";
        Restart = "always";
      };
    };

    cliphist = mkService {
      Unit.Description = "Clipboard history";
      Service = {
        ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${lib.getBin pkgs.cliphist}/cliphist store";
        Restart = "always";
      };
    };
  };

  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };
}
