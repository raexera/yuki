{
  config,
  lib,
  pkgs,
  ...
}: let
  MHz = x: x * 1000;
  inherit (lib) mkDefault;
in {
  imports = [./hardware-configuration.nix];

  boot = {
    kernelModules = ["acpi_call"];
    blacklistedKernelModules = ["nouveau"];
    extraModulePackages = with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
      ]
      ++ [pkgs.cpupower-gui];
    extraModprobeConfig = ''
      blacklist nouveau
      options nouveau modeset=0
    '';
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "iommu=pt"
      "i8042.direct"
      "i8042.dumbkbd"
      "i915.enable_psr=0"
      "i915.modeset=1"
      "nvidia_drm.modeset=1"
      "nvidia_drm.fbdev=1"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];

    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 3;
        gfxmodeEfi = "1920x1080";
      };
    };
  };

  environment = {
    systemPackages = with pkgs; [
      acpi
      libva
      libva-utils
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
    ];

    variables = {
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      GDK_SCALE = "2";
      WLR_NO_HARDWARE_CURSORS = "1";
      WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
    };
  };

  hardware = {
    enableAllFirmware = true;

    opengl = {
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiIntel
        libvdpau-va-gl
        vaapiVdpau
        intel-ocl
        nvidia-vaapi-driver
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vaapiIntel
        libvdpau-va-gl
        vaapiVdpau
      ];
    };

    nvidia = {
      modesetting.enable = true;
      powerManagement = {
        enable = true;
        finegrained = true;
      };
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  networking.hostName = "yuki";

  services = {
    fstrim.enable = true;
    thermald.enable = true;

    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 15;
      percentageAction = 10;
      criticalPowerAction = "Hibernate";
    };

    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          scaling_min_freq = mkDefault (MHz 1800);
          scaling_max_freq = mkDefault (MHz 3600);
          turbo = "never";
        };
        charger = {
          governor = "performance";
          scaling_min_freq = mkDefault (MHz 2000);
          scaling_max_freq = mkDefault (MHz 4800);
          turbo = "auto";
        };
      };
    };

    xserver.videoDrivers = ["nvidia"];
  };

  zramSwap.enable = true;
}
