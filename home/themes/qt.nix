{
  config,
  pkgs,
  ...
}: {
  home = {
    packages = with pkgs; [
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
      libsForQt5.qt5.qttools
      qt6Packages.qtstyleplugin-kvantum
      breeze-icons
    ];

    sessionVariables = {
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    };
  };

  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      name = "Catppuccin-Macchiato-Dark";
      package = pkgs.catppuccin-kde.override {
        flavour = ["macchiato"];
        accents = ["mauve"];
        winDecStyles = ["modern"];
      };
    };
  };

  xdg.configFile = {
    "kdeglobals".source = "${config.qt.style.package}" + "/share/color-schemes/CatppuccinMacchiatoMauve.colors";

    "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
      General.theme = "catppuccin";
      Applications.catppuccin = ''
        qt5ct, org.kde.dolphin, org.kde.kalendar, org.qbittorrent.qBittorrent, hyprland-share-picker
      '';
    };

    "Kvantum/catppuccin/catppuccin.kvconfig".source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Macchiato-Mauve/Catppuccin-Macchiato-Mauve.kvconfig";
      sha256 = "0k2icaybydqp65cic2saxvgrn039bk7kq7rqm75ffxgpmv04jakp";
    };

    "Kvantum/catppuccin/catppuccin.svg".source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Macchiato-Mauve/Catppuccin-Macchiato-Mauve.svg";
      sha256 = "1qcca56f1452qriclxwlkw5p17k9n99fw34hwp4s8v24r0azcwv5";
    };
  };
}
