{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  MHz = x: x * 1000;
  inherit (lib) mkDefault;
in {
  imports = [./hardware-configuration.nix];

  boot = {
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages;
      [
        acpi_call
        cpupower
      ]
      ++ [pkgs.cpupower-gui];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "i8042.direct"
      "i8042.dumbkbd"
      "i915.enable_psr=0"
      "iommu=pt"
      "module_blacklist=nouveau"
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    ];

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    acpi
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
  ];

  hardware = {
    enableAllFirmware = true;
    opengl = {
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
    thermald.enable = true;
    power-profiles-daemon.enable = true;

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
}
