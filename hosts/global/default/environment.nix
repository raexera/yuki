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
        dbus
        dconf
        ffmpeg-full
        gcc
        git
        gimp
        glib
        glxinfo
        gnumake
        gnuplot
        gnused
        gnutls
        imagemagick
        inotify-tools
        iw
        keepassxc
        libappindicator
        libcanberra-gtk3
        libgudev
        libnotify
        libsecret
        librsvg
        libtool
        pamixer
        pavucontrol
        pulseaudio
        wirelesstools
        nautilus-open-any-terminal
        zoom-us
        ;

      inherit
        (pkgs.gnome)
        dconf-editor
        eog
        gnome-disk-utility
        nautilus
        sushi
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
