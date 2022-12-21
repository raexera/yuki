{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./nvidia.nix

    # Shared configuration across all machines
    ../shared
    ../shared/users/rxyhn.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "i915.force_probe=46a6"
      "i915.enable_psr=0"
      "i915.enable_guc=2"
      "i8042.direct"
      "i8042.dumbkbd"
    ];

    supportedFilesystems = ["btrfs"];

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      systemd-boot.enable = false;

      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        enableCryptodisk = true;
        configurationLimit = 3;
      };
    };
  };

  hardware = {
    opengl = with pkgs; {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = [
        intel-compute-runtime
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = [
        libva
      ];
    };

    bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };

    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
  };

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };

  # compresses half the ram for use as swap
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  services = {
    btrfs.autoScrub.enable = true;
    acpid.enable = true;
    thermald.enable = true;
    upower.enable = true;

    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 0;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "Hyprland";
          user = "rxyhn";
        };
        default_session = initial_session;
      };
    };

    # add hyprland to display manager sessions
    xserver.displayManager.sessionPackages = [inputs.hyprland.packages.${pkgs.system}.default];
  };

  # selectable options
  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # enable hyprland
  programs.hyprland.nvidiaPatches = true;

  security = {
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    acpi
    blueberry
    brightnessctl
    pavucontrol
    docker-client
    libva-utils
    mesa
    polkit_gnome
    spice-gtk
    swtpm
    virt-manager

    egl-wayland
    qt5.qtwayland
    qt5ct
  ];

  virtualisation = {
    spiceUSBRedirection.enable = true;

    docker = {
      enable = true;
      enableNvidia = true;
    };

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        ovmf = {
          enable = true;
          packages = with pkgs; [OVMFFull.fd];
        };
        swtpm.enable = true;
      };
    };
  };

  system.stateVersion = lib.mkForce "22.11"; # DONT TOUCH THIS
}
