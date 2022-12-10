# This file (and the global directory) holds config that i use on all hosts
{
  lib,
  pkgs,
  self,
  inputs,
  ...
}: {
  imports = [
    ./fonts.nix
    ./locale.nix
    ./nix.nix
  ];

  environment = {
    binsh = "${pkgs.bash}/bin/bash";
    shells = with pkgs; [zsh];

    systemPackages = lib.attrValues {
      inherit
        (pkgs)
        alsa-lib
        alsa-plugins
        alsa-tools
        alsa-utils
        cairo
        cmake
        coreutils
        curl
        fd
        findutils
        ffmpeg
        fzf
        gcc
        git
        glib
        gnumake
        gnutls
        gnuplot
        gtk3
        gtk4
        imagemagick
        inotify-tools
        jq
        libtool
        libappindicator
        libnotify
        libsecret
        librsvg
        lm_sensors
        man-pages
        man-pages-posix
        nodejs
        pamixer
        pciutils
        pkgconfig
        psmisc
        pulseaudio
        ripgrep
        rsync
        unrar
        unzip
        util-linux
        vim
        wget
        wirelesstools
        xarchiver
        xclip
        xdg-utils
        xh
        zip
        ;
    };
  };

  programs = {
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    npm = {
      enable = true;
      npmrc = ''
        prefix = ''${HOME}/.npm
        color = true
      '';
    };

    java = {
      enable = true;
      package = pkgs.jre;
    };
  };

  security.rtkit.enable = true;

  # Increase open file limit for sudoers
  security.pam.loginLimits = [
    {
      domain = "@wheel";
      item = "nofile";
      type = "soft";
      value = "524288";
    }
    {
      domain = "@wheel";
      item = "nofile";
      type = "hard";
      value = "1048576";
    }
  ];
}
