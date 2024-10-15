{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../modules/dev

    ../modules/wayland/windowManager/hyprland

    ../modules/programs/firefox.nix
    ../modules/programs/gtk.nix
    ../modules/programs/kitty.nix
    ../modules/programs/media
    ../modules/programs/nix-index-db.nix
    ../modules/programs/qt.nix
    ../modules/programs/vscode

    ../modules/services/blueman-applet.nix
    ../modules/services/polkit-agent.nix
    ../modules/services/udiskie.nix
  ];

  home = {
    packages = lib.attrValues {
      # Utilities
      inherit
        (pkgs)
        atool
        bc
        catimg
        chafa
        coreutils
        curl
        du-dust
        duf
        editorconfig-core-c
        elinks
        exiftool
        fd
        file
        findutils
        gawk
        glow
        gnumake
        gnused
        hyperfine
        imagemagick
        jaq
        jq
        killall
        lz4
        neofetch
        nvd
        p7zip
        procs
        psmisc
        ripgrep
        rsync
        sd
        socat
        trash-cli
        ttyper
        unrar
        unzip
        util-linux
        wget
        xarchiver
        yt-dlp
        zathura
        zip
        ;

      # GUI
      inherit
        (pkgs)
        keepassxc
        tdesktop
        obsidian
        ;
    };
  };
}
