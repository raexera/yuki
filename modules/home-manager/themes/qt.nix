{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      breeze-icons
      libsForQt5.qt5ct
      libsForQt5.qt5.qttools
      libsForQt5.qtstyleplugin-kvantum
      qt6Packages.qtstyleplugin-kvantum
    ];

    sessionVariables = {
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      DISABLE_QT_COMPAT = "0";
    };
  };

  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      name = "Catppuccin-Macchiato-Dark";
      package = pkgs.catppuccin-kde.override {
        flavour = ["macchiato"];
        accents = ["blue"];
        winDecStyles = ["modern"];
      };
    };
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
      General.theme = "catppuccin";
      Applications.catppuccin = ''
        qt5ct, org.kde.dolphin, org.qbittorrent.qBittorrent, hyprland-share-picker
      '';
    };

    "Kvantum/catppuccin/catppuccin.kvconfig".source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Macchiato-Blue/Catppuccin-Macchiato-Blue.kvconfig";
      sha256 = "0v29wflyskb34nqsjy4y67cxy46rg3r9wnivwff96dwh39rl61qd";
    };

    "Kvantum/catppuccin/catppuccin.svg".source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Macchiato-Blue/Catppuccin-Macchiato-Blue.svg";
      sha256 = "1gqxrcq65nfsvplv3n6srsl054hn26mkqjnx6snnkryj98s2abd5";
    };
  };
}
