{pkgs, ...}: {
  imports = [
    ./programs/firefox.nix
    ./programs/kitty.nix
    ./programs/media.nix
    ./programs/packages.nix
    ./programs/tools.nix
    ./programs/vscode.nix
  ];

  home = {
    packages = with pkgs; [
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
      joshuto
      jq
      killall
      lz4
      neofetch
      p7zip
      perl
      procs
      psmisc
      ripgrep
      rsync
      sd
      socat
      trash-cli
      tree
      unrar
      unzip
      util-linux
      wget
      xarchiver
      yt-dlp
      zathura
      zip
    ];

    sessionVariables = {
      DIRENV_LOG_FORMAT = "";
      NIX_AUTO_RUN = "1";
    };
  };
}
