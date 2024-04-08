{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./dconf.nix

    ../../modules/dev
    ../../modules/config/gtk.nix
    ../../modules/config/home-cursor.nix
    ../../modules/programs/discord.nix
    ../../modules/programs/firefox.nix
    ../../modules/programs/kitty.nix
    ../../modules/programs/nix-index-db.nix
    ../../modules/programs/media
    ../../modules/programs/vscode
    ../../modules/services/udiskie.nix
    ../../modules/services/blueman-applet.nix
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
