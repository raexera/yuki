{
  pkgs,
  lib,
  inputs,
  ...
}: let
  theme = import ../../theme/theme.nix inputs;
in {
  # enable zsh autocompletion for system packages (systemd, etc)
  environment.pathsToLink = ["/share/zsh"];

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8"];
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = lib.mkDefault "Asia/Jakarta";
  };

  console = let
    normal = with theme.colors; [base red green yellow blue mauve teal subtext1];
    bright = with theme.colors; [surface0 red green yellow blue mauve teal subtext0];
  in {
    colors = normal ++ bright;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
  };

  networking = {
    # dns
    nameservers = ["1.1.1.1" "1.0.0.1"];
    networkmanager = {
      enable = true;
    };
  };

  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;

  # pickup pkgs from flake export
  nixpkgs.pkgs = inputs.self.pkgs;

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

  environment.variables = {
    GTK_THEME = "Catppuccin-Macchiato-Mauve";
    XCURSOR_THEME = "Catppuccin-Macchiato-Dark";
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
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      jetbrains-mono
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    ];

    enableDefaultFonts = false;

    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif" "Noto Color Emoji"];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };

  environment = {
    binsh = "${pkgs.bash}/bin/bash";
    shells = with pkgs; [zsh];

    systemPackages = with pkgs; [
      acpi
      clang
      clang-tools
      cmake
      coreutils
      curl
      dbus
      docker-client
      ffmpeg
      findutils
      gnumake
      gnutls
      gnuplot
      man-pages
      man-pages-posix
      mesa
      neovim
      polkit_gnome
      unrar
      unzip
      util-linux
      vim
      virt-manager
      wget
      xarchiver
      zip
    ];
  };

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
    pulseaudio.enable = false;

    bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };
  };

  # compresses half the ram for use as swap
  zramSwap.enable = true;

  imports = [
    ./nix-settings.nix
    ./programs.nix
    ./services.nix
    ./users.nix
  ];

  system.stateVersion = lib.mkDefault "22.05"; # DONT TOUCH THIS
}
