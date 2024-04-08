{pkgs, ...}: let
  defaultExtensions = with pkgs.gnomeExtensions; [
    blur-my-shell
    dash-to-dock
    just-perfection
  ];
in {
  home.packages = with pkgs;
    [
      gnome-extension-manager
    ]
    ++ defaultExtensions;

  dconf.settings = {
    "org/gnome/shell".enabled-extensions = builtins.map (extension: extension.extensionUuid) defaultExtensions;

    "org/gnome/shell/extensions/blur-my-shell" = {
      brightness = 0.9;
    };

    "org/gnome/shell/extensions/dash-to-dock" = {
      autohide = true;
      background-opacity = 0.0;
      click-action = "previews";
      dock-fixed = true;
      dock-position = "BOTTOM";
      hot-keys = false;
      pressure-threshold = 200.0;
      require-pressure-to-show = true;
      scroll-action = "cycle-windows";
      show-favorites = true;
      show-trash = true;
      transparency-mode = "fixed";
    };

    "org/gnome/shell/extensions/just-perfection" = {
      panel-size = 48;
      activities-button = false;
    };
  };
}
