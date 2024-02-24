{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.hyprland.nixosModules.default

    ./greetd.nix
  ];

  environment = {
    variables = {
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland,x11";
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
    inputs.anyrun.homeManagerModules.default
    inputs.hyprland.homeManagerModules.default
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
    # allow wayland lockers to unlock the screen
    pam.services.hyprlock.text = "auth include login";
  };

  xdg.portal = {
    enable = true;

    config = {
      common.default = ["gtk"];
      hyprland.default = ["gtk" "hyprland"];
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };
}
