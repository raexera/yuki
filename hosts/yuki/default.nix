{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  boot = {
    initrd = {
      kernelModules = ["ideapad_laptop"];

      luks.devices = {
        crypted = {
          device = "/dev/disk/by-uuid/482c1bf8-9441-4fc4-979b-7daf22649451";
          preLVM = true;
          allowDiscards = true;
        };
      };
    };

    kernelParams = ["iommu=pt"];

    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
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
  };

  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;

    nvidia.prime = {
      reverseSync.enable = true;
      allowExternalGpu = false;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  networking.hostName = "yuki";

  services = {
    acpid.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    hardware.bolt.enable = true;

    logind = {
      powerKey = "suspend";
      lidSwitch = "suspend";
      lidSwitchExternalPower = "lock";
    };

    psd = {
      enable = true;
      resyncTimer = "10m";
    };

    power-profiles-daemon.enable = true;
    thermald.enable = true;

    upower = {
      enable = true;
      percentageLow = 30;
      percentageCritical = 20;
      percentageAction = 10;
      criticalPowerAction = "Hibernate";
    };

    xserver.videoDrivers = [
      "intel"
      "nvidia"
    ];
  };
}
