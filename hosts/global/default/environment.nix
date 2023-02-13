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
        bc
        bandwhich
        bottom
        btop
        cairo
        cmake
        coreutils
        curl
        dbus
        dconf
        du-dust
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
        keepassxc
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
        neofetch
        nodejs
        ntfs3g
        nvme-cli
        p7zip
        pamixer
        pavucontrol
        pciutils
        procs
        psmisc
        pulseaudio
        ripgrep
        rsync
        sd
        tree
        unrar
        unzip
        util-linux
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
