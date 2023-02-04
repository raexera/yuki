{
  lib,
  pkgs,
  ...
}: {
  environment = {
    binsh = "${pkgs.bash}/bin/bash";
    shells = with pkgs; [zsh];
    pathsToLink = ["/share/zsh"];

    loginShellInit = ''
      dbus-update-activation-environment --all
      eval $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
      eval $(ssh-agent)
    '';

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
        dconf
        fd
        findutils
        ffmpeg-full
        fzf
        gcc
        git
        glib
        gnumake
        gnuplot
        gnused
        gnutls
        imagemagick
        iw
        jq
        killall
        lz4
        libappindicator
        libsecret
        librsvg
        libtool
        lm_sensors
        man-pages
        man-pages-posix
        nodejs
        ntfs3g
        nvme-cli
        p7zip
        pamixer
        pavucontrol
        pciutils
        psmisc
        pulseaudio
        ripgrep
        unrar
        unzip
        util-linux
        vim
        wget
        xarchiver
        zip
        ;
    };

    variables = {
      EDITOR = "hx";
      BROWSER = "firefox";
      _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };
  };
}
