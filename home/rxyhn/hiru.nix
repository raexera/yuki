{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./programs/firefox.nix
    ./programs/kitty.nix
    ./programs/media.nix
    ./programs/nix-index-db.nix
    ./programs/vscode.nix
  ];

  home = {
    packages = lib.attrValues {
      # DEV Tools
      inherit
        (pkgs)
        black
        bun
        ccls
        clang
        clang-tools
        cmake
        delve
        go
        gopls
        grex
        java-language-server
        jre8
        lldb
        nodejs
        shellcheck
        shfmt
        typescript
        uncrustify
        zig
        zls
        ;

      inherit
        (pkgs.nodePackages_latest)
        jsonlint
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
        gnused
        hyperfine
        imagemagick
        jaq
        jq
        killall
        lz4
        neofetch
        p7zip
        procs
        psmisc
        ripgrep
        rsync
        sd
        socat
        trash-cli
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
        discord
        gimp
        keepassxc
        tdesktop
        obsidian
        ;
    };
  };
}
