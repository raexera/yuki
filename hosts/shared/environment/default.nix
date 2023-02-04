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
        cmake
        coreutils
        curl
        fd
        ffmpeg
        fzf
        gcc
        git
        glib
        gnumake
        gnutls
        hddtemp
        imagemagick
        iw
        jq
        lz4
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
        vim
        wget
        wirelesstools
        xarchiver
        xclip
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
