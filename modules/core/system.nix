{
  config,
  pkgs,
  ...
}: let
  theme = import ../../theme/theme.nix {};
in {
  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Asia/Jakarta";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8/UTF-8"];
  };

  console = let
    normal = with theme.colors; [bg c1 c2 c3 c4 c5 c6 c7];
    bright = with theme.colors; [lbg c9 c10 c11 c12 c13 c14 c15];
  in {
    colors = normal ++ bright;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
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
      package = pkgs.jdk;
    };

    adb.enable = true;
    dconf.enable = true;
    nm-applet.enable = true;
    seahorse.enable = true;
  };

  systemd.services = {
    seatd = {
      enable = true;
      description = "Seat management daemon";
      script = "${pkgs.seatd}/bin/seatd -g wheel";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = "1";
      };
      wantedBy = ["multi-user.target"];
    };
  };

  services = {
    dbus = {
      packages = with pkgs; [dconf];
      enable = true;
    };

    udev.packages = with pkgs; [gnome.gnome-settings-daemon];

    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    logind = {
      lidSwitch = "suspend-then-hibernate";
      lidSwitchExternalPower = "lock";
      extraConfig = ''
        HandlePowerKey=suspend-then-hibernate
        HibernateDelaySec=3600
      '';
    };

    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 0;
        STOP_CHARGE_THRESH_BAT0 = 85;
      };
    };

    acpid.enable = true;
    upower.enable = true;
    thermald.enable = true;
    blueman.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    lorri.enable = true;
    udisks2.enable = true;
    printing.enable = true;
    fstrim.enable = true;
    ratbagd.enable = true;

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  environment.variables = {
    GTK_THEME = "Catppuccin-Frappe-Pink";
    XCURSOR_THEME = "Catppuccin-Frappe-Dark";
    XCURSOR_SIZE = "24";
    EDITOR = "nvim";
    BROWSER = "firefox";
    FLAKE = "~/dotfiles";
  };

  fonts = {
    fonts = with pkgs; [
      material-icons
      material-design-icons
      roboto
      work-sans
      comic-neue
      source-sans
      twemoji-color-font
      comfortaa
      inter
      lato
      dejavu_fonts
      iosevka-bin
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      jetbrains-mono
      (nerdfonts.override {fonts = ["Iosevka" "JetBrainsMono"];})
    ];

    enableDefaultFonts = false;

    # this fixes emoji stuff
    fontconfig = {
      defaultFonts = {
        monospace = [
          "Iosevka Term"
          "Iosevka Term Nerd Font Complete Mono"
          "Iosevka Nerd Font"
          "Noto Color Emoji"
        ];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        serif = ["Noto Serif" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    fzf
    acpi
    cmake
    clang
    clang-tools
    coreutils
    curl
    ffmpeg
    gnumake
    gnutls
    gnuplot
    man-pages
    man-pages-posix
    polkit_gnome
    unrar
    unzip
    xarchiver
    zip
    wget
    vim
    gnome.adwaita-icon-theme
    virt-manager
    docker-client
  ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
        swtpm.enable = true;
      };
    };
    docker.enable = true;
    lxd.enable = true;
  };

  powerManagement.cpuFreqGovernor = "powersave";

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    pulseaudio.support32Bit = true;

    bluetooth = {
      enable = true;
      package = pkgs.bluezFull;
    };
  };
}
