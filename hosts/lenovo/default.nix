{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    # Shared configuration across all machines
    ../shared
  ];

  boot = {
    # Use the latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    # Make modules available to modprobe
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];

    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["btrfs"];
    };

    # Load modules on boot
    kernelModules = ["acpi_call"];

    # Kernel parameters
    kernelParams = [
      "i915.force_probe=46a6"
      "i915.enable_psr=0"
      "i915.enable_guc=2"
      "i8042.direct"
      "i8042.dumbkbd"
    ];
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver # iHD
        libva
        libvdpau
        libvdpau-va-gl
        (vaapiIntel.override {enableHybridCodec = true;}) # i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
      ];
    };

    bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };

    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
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
  };

  environment = {
    variables = {
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "0.5";
    };

    systemPackages = with pkgs; [
      acpi
      brightnessctl
      gcc
      libva-utils
      ocl-icd
      vulkan-tools
    ];
  };

  modules.nixos = {
    bootloader.grub = {
      enable = true;
      efiSysMountPoint = "/boot";
      device = "nodev";
    };

    hardware.nvidia.enable = true;

    virtualisation = {
      docker = {
        enable = true;
        enableNvidia = true;
      };

      libvirtd.enable = true;

      podman = {
        enable = true;
        enableNvidia = true;
      };
    };

    windowManager.awesome = {
      enable = true;
      layout = "us";
    };
  };

  system.stateVersion = lib.mkForce "22.11"; # DONT TOUCH THIS
}
