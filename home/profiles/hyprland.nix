{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../modules/wayland/windowManager/hyprland
    ../modules/config/gtk.nix
    ../modules/config/home-cursor.nix

    ../modules/programs/discord.nix
    ../modules/programs/firefox.nix
    ../modules/programs/kitty.nix
    ../modules/programs/nix-index-db.nix
    ../modules/programs/media
    ../modules/programs/vscode

    ../modules/services/udiskie.nix
  ];

  home = {
    packages = lib.attrValues {
      # DEV Tools
      inherit
        (pkgs)
        alejandra
        black
        bun
        ccls
        clang
        clang-tools
        cmake
        delve
        deno
        go
        gopls
        grex
        java-language-server
        just
        lldb
        nodejs
        revive
        shellcheck
        shfmt
        typescript
        uncrustify
        zig
        zls
        ;

      inherit
        (pkgs.nodePackages)
        jsonlint
        pnpm
        prettier
        typescript-language-server
        vls
        vscode-langservers-extracted
        yaml-language-server
        yarn
        ;

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
        gimp
        keepassxc
        tdesktop
        obsidian
        ;
    };
  };
}
