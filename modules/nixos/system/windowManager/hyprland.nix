{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  environment = {
    variables = {
      NIXOS_OZONE_WL = "1";
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      GDK_BACKEND = "wayland,x11";
      GTK_USE_PORTAL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_SESSION_TYPE = "wayland";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };

    systemPackages = with pkgs; [
      libsForQt5.dolphin
      libsForQt5.ark
      libsForQt5.gwenview
      libsForQt5.dolphin-plugins
      libsForQt5.ffmpegthumbs
      libsForQt5.kdegraphics-thumbnailers
      libsForQt5.kimageformats
      libsForQt5.kio
      libsForQt5.kio-extras
      libsForQt5.qtwayland
      libsForQt5.okular
    ];
  };

  nixpkgs.overlays = [
    inputs.nixpkgs-wayland.overlay
  ];

  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
    ];

    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  home-manager.sharedModules = [
    inputs.self.homeModules.hyprland
    inputs.ags.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
  ];

  xdg.portal = {
    enable = true;
    config.common.default = "*";
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
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

    greetd = let
      session = {
        command = "${lib.getExe config.programs.hyprland.package}";
        user = "rxyhn";
      };
    in {
      enable = true;
      settings = {
        terminal.vt = 1;
        default_session = session;
        initial_session = session;
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
}
