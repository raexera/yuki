{
  lib,
  pkgs,
  config,
  ...
}: let
  KvLibadwaita = pkgs.fetchFromGitHub {
    owner = "GabePoel";
    repo = "KvLibadwaita";
    rev = "87c1ef9f44ec48855fd09ddab041007277e30e37";
    hash = "sha256-K/2FYOtX0RzwdcGyeurLXAh3j8ohxMrH2OWldqVoLwo=";
    sparseCheckout = ["src"];
  };
in {
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  home.packages = with pkgs; [
    qt6Packages.qtstyleplugin-kvantum
    qt6Packages.qt6ct
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
  ];

  xdg.configFile = {
    "Kvantum" = {
      source = "${KvLibadwaita}/src";
      recursive = true;
    };

    "Kvantum/kvantum.kvconfig".text = lib.generators.toINI {} {
      General.theme = "KvLibadwaitaDark";
    };

    "qt5ct/qt5ct.conf".text = lib.generators.toINI {} {
      Appearance = {
        color_scheme_path = "${pkgs.libsForQt5.qt5ct}/share/qt5ct/colors/darker.conf";
        custom_palette = true;
        icon_theme = config.gtk.iconTheme.name;
        standard_dialogs = "xdgdesktopportal";
        style = "kvantum-dark";
      };

      Fonts = {
        fixed = ''"JetBrainsMono Nerd Font Propo,12,-1,5,50,0,0,0,0,0,Regular"'';
        general = ''"Inter,12,-1,5,50,0,0,0,0,0"'';
      };
    };

    "qt6ct/qt6ct.conf".text = lib.generators.toINI {} {
      Appearance = {
        color_scheme_path = "${pkgs.kdePackages.qt6ct}/share/qt6ct/colors/darker.conf";
        custom_palette = true;
        icon_theme = config.gtk.iconTheme.name;
        standard_dialogs = "xdgdesktopportal";
        style = "kvantum-dark";
      };

      Fonts = {
        fixed = ''"JetBrainsMono Nerd Font Propo,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
        general = ''"Inter,12,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular"'';
      };
    };
  };
}
