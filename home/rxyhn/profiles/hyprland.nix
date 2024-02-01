{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../programs/discord.nix
    ../programs/firefox.nix
    ../programs/kitty.nix
    ../programs/nix-index-db.nix
    ../programs/media
    ../programs/vscode
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
