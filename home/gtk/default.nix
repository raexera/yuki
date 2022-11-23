{
  pkgs,
  config,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Macchiato-Mauve";
      package = pkgs.catppuccin-gtk;
    };
    iconTheme = {
      name = "Papirus";
      package = pkgs.catppuccin-folders;
    };
    font = {
      name = "Lato";
      size = 13;
    };
    gtk3.extraConfig = {
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "rgb";
    };
    gtk2.extraConfig = ''
      gtk-xft-antialias=1
      gtk-xft-hinting=1
      gtk-xft-hintstyle="hintslight"
      gtk-xft-rgba="rgb"
    '';
  };

  # cursor theme
  home.pointerCursor = {
    name = "Catppuccin-Macchiato-Dark";
    package = pkgs.catppuccin-cursors;
    size = 24;
  };

  home.pointerCursor.gtk.enable = true;

  # credits: bruhvko
  # catppuccin theme for qt-apps
  home.packages = with pkgs; [libsForQt5.qtstyleplugin-kvantum];

  xdg.configFile."Kvantum/catppuccin/catppuccin.kvconfig".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Macchiato-Mauve/Catppuccin-Macchiato-Mauve.kvconfig";
    sha256 = "0k2icaybydqp65cic2saxvgrn039bk7kq7rqm75ffxgpmv04jakp";
  };
  xdg.configFile."Kvantum/catppuccin/catppuccin.svg".source = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/Kvantum/main/src/Catppuccin-Macchiato-Mauve/Catppuccin-Macchiato-Mauve.svg";
    sha256 = "1qcca56f1452qriclxwlkw5p17k9n99fw34hwp4s8v24r0azcwv5";
  };
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=catppuccin

    [Applications]
    catppuccin=Dolphin, dolphin, Nextcloud, nextcloud, qt5ct, org.kde.dolphin, org.kde.kalendar, kalendar, Kalendar, qbittorrent, org.qbittorrent.qBittorrent
  '';
}
