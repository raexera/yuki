{
  inputs,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    extraModprobeConfig = ''
      options snd-intel-dspcfg dsp_driver=1
    '';

    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
    ];

    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["ext4"];
    };

    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 5;
        gfxmodeEfi = "1920x1080";
      };
    };

    plymouth.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      acpi
      alsa-utils
      ffmpeg-full
      libva
      libva-utils
      mesa
      pciutils
      v4l-utils
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
      vulkan-extension-layer
    ];

    sessionVariables = {
      WLR_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
    };
  };

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;

    nvidia.prime = {
      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  networking.hostName = "yuki";

  security.tpm2.enable = true;

  services = {
    acpid.enable = true;
    auto-cpufreq.enable = true;
    fstrim.enable = true;
    hardware.bolt.enable = true;
    power-profiles-daemon.enable = true;

    howdy = {
      enable = true;
      package = inputs.nixpkgs-howdy.legacyPackages.${pkgs.system}.howdy;
      settings = {
        video.device_path = "/dev/video0";
      };
    };

    linux-enable-ir-emitter = {
      enable = true;
      package = inputs.nixpkgs-howdy.legacyPackages.${pkgs.system}.linux-enable-ir-emitter;
    };

    psd = {
      enable = true;
      resyncTimer = "10m";
    };

    thermald.enable = true;

    upower = {
      enable = true;
      percentageLow = 30;
      percentageCritical = 20;
      percentageAction = 10;
      criticalPowerAction = "Hibernate";
    };
  };

  zramSwap.enable = true;
}
