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
    ./network.nix
    ./nix.nix
    ./ssh.nix
  ];

  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
  };

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

    loginShellInit = ''
      dbus-update-activation-environment --systemd DISPLAY
      eval $(gnome-keyring-daemon --start --daemonize --components=ssh)
      eval $(ssh-agent)
    '';
  };

  programs = {
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';

    adb.enable = true;
    dconf.enable = true;
    nm-applet.enable = true;
    seahorse.enable = true;

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

  services = {
    blueman.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    lorri.enable = true;
    udisks2.enable = true;
    printing.enable = true;
    fstrim.enable = true;

    udev.packages = with pkgs; [gnome.gnome-settings-daemon];

    dbus = {
      enable = true;
      packages = with pkgs; [dconf gcr];
    };

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    pipewire = {
      enable = true;
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    logind = {
      lidSwitch = "suspend-then-hibernate";
      lidSwitchExternalPower = "lock";
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        HibernateDelaySec=3600
      '';
    };
  };

  systemd.user.services = {
    pipewire.wantedBy = ["default.target"];
    pipewire-pulse.wantedBy = ["default.target"];
  };

  security = {
    rtkit.enable = true;

    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };

    pam = {
      services.login.enableGnomeKeyring = true;

      loginLimits = [
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
    };
  };
}
