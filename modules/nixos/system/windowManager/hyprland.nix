{
  config,
  inputs,
  lib,
  pkgs,
  themes,
  ...
}: {
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  console.colors = let
    inherit (themes.colorscheme) colors;
  in [
    colors.black2
    colors.red
    colors.green
    colors.yellow
    colors.blue
    colors.mauve
    colors.teal
    colors.white
    colors.black2
    colors.red
    colors.green
    colors.yellow
    colors.blue
    colors.mauve
    colors.teal
    colors.white
  ];

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
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };

    systemPackages = with pkgs; [
      ark
      ffmpegthumbnailer
      libgsf
      xfce.tumbler
    ];
  };

  home-manager.sharedModules = [
    inputs.ags.homeManagerModules.default
    inputs.anyrun.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
    inputs.self.homeModules.hyprland
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
