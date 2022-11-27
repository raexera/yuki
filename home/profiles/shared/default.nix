{
  inputs,
  pkgs,
  config,
  ...
}: let
  mpv-unwrapped = pkgs.mpv-unwrapped.overrideAttrs (o: {
    src = pkgs.fetchFromGitHub {
      owner = "mpv-player";
      repo = "mpv";
      rev = "48ad2278c7a1fc2a9f5520371188911ef044b32c";
      sha256 = "sha256-6qbv34ysNQbI/zff6rAnVW4z6yfm2t/XL/PF7D/tjv4=";
    };
  });
in {
  home = {
    packages = with pkgs; [
      # Apps
      cinnamon.nemo
      gtk3
      gtk4
      libsForQt5.qtstyleplugin-kvantum
      mpv-unwrapped
      pavucontrol
      zoom-us

      # CLI Tools
      bandwhich
      cachix
      dconf
      dbus
      docker-compose
      fd
      fzf
      gcc
      gh
      ghq
      glib
      glxinfo
      grex
      hyperfine
      imagemagick
      jq
      killall
      lm_sensors
      ripgrep
      rsync
      todo
      trash-cli
      xh
      xorg.xhost

      # Utilities
      alsa-lib
      alsa-plugins
      alsa-utils
      brightnessctl
      libnotify
      pamixer
      playerctl
      xdg-user-dirs
      xdg-utils

      # Language servers
      ccls
      go
      gopls
      nil
      nodejs
      nodePackages.pyright
      nodePackages.prettier
      nodePackages.stylelint
      nodePackages.jsonlint
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.yarn
      nodePackages.bash-language-server
      nodePackages.node2nix
      rust-analyzer
      sumneko-lua-language-server
      uncrustify

      # Formatters
      asmfmt
      black
      ktlint
      shfmt
      stylua
    ];

    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];

    sessionVariables = {
      BROWSER = "${pkgs.firefox}/bin/firefox";
      EDITOR = "${pkgs.neovim}/bin/nvim";
      GOPATH = "${config.home.homeDirectory}/Extras/go";
      RUSTUP_HOME = "${config.home.homeDirectory}/.local/share/rustup";
      XDG_DATA_HOME = "${config.home.homeDirectory}/.local/share";
    };
  };

  services.playerctld.enable = true;

  # catppuccin theme for gtk-apps
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

  # catppuccin theme for qt-apps
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

  imports = [
    ../../programs/kitty.nix
    ../../programs/vscode.nix
    ../../programs/firefox.nix
    ../../programs/mpd.nix
    ../../programs/zathura.nix
  ];
}
