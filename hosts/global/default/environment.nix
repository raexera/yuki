{
  lib,
  pkgs,
  ...
}: {
  environment = {
    binsh = "${pkgs.bash}/bin/bash";
    shells = [pkgs.zsh];
    pathsToLink = ["/share/zsh"];

    loginShellInit = ''
      dbus-update-activation-environment --all
      eval $(ssh-agent)
      eval $(gnome-keyring-daemon --start --daemonize --components=pkcs11,secrets,ssh)
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
        inotify-tools
        iw
        jq
        killall
        lz4
        libappindicator
        libcanberra-gtk3
        libgudev
        libnotify
        libsecret
        librsvg
        libtool
        lm_sensors
        man-pages
        man-pages-posix
        mpg123
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
