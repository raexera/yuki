{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  environment = {
    variables = {
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland,x11";
      GTK_USE_PORTAL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      NIXOS_OZONE_WL = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      XDG_SESSION_TYPE = "wayland";
    };

    systemPackages = with pkgs; [
      ark
      ffmpegthumbnailer
      libgsf
    ];
  };

  home-manager.sharedModules = [
    inputs.ags.homeManagerModules.default
    inputs.anyrun.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
    inputs.self.homeManagerModules.hyprland
  ];

  nixpkgs.overlays = [
    inputs.nixpkgs-wayland.overlay
  ];

  programs = {
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-dropbox-plugin
        thunar-media-tags-plugin
        thunar-volman
      ];
    };
  };

  security = {
    pam.services = {
      greetd = {
        gnupg.enable = true;
        enableGnomeKeyring = true;
      };

      login = {
        enableGnomeKeyring = true;
        gnupg = {
          enable = true;
          noAutostart = true;
          storeOnly = true;
        };
      };

      swaylock.text = "auth include login";
    };

    polkit.enable = true;
  };

  services = {
    gnome = {
      gnome-keyring.enable = true;
      glib-networking.enable = true;
    };

    greetd = {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session = let
          base = config.services.xserver.displayManager.sessionData.desktops;
        in {
          command = lib.concatStringsSep " " [
            (lib.getExe pkgs.greetd.tuigreet)
            "--time"
            "--remember"
            "--remember-user-session"
            "--asterisks"
            "--sessions '${base}/share/wayland-sessions:${base}/share/xsessions'"
          ];
          user = "greeter";
        };
      };
    };
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
