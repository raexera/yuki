{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault;
in {
  imports = [./hardware-configuration.nix];

  boot = {
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
    kernelPackages = pkgs.linuxPackages_latest;

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
      pciutils
    ];

    sessionVariables = {
      WLR_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };

  hardware = {
    enableAllFirmware = mkDefault true;
    enableRedistributableFirmware = mkDefault true;

    nvidia.prime = {
      nvidiaBusId = mkDefault "PCI:1:0:0";
      intelBusId = mkDefault "PCI:0:2:0";
    };

    opengl = {
      enable = mkDefault true;
      driSupport = mkDefault true;
      driSupport32Bit = mkDefault true;
    };
  };

  networking.hostName = "yuki";

  services = {
    acpid.enable = true;
    auto-cpufreq.enable = true;
    fstrim.enable = true;
    hardware.bolt.enable = true;
    power-profiles-daemon.enable = true;

    psd = {
      enable = true;
      resyncTimer = "10m";
    };

    thermald.enable = true;

    upower = {
      enable = true;
      percentageLow = 25;
      percentageCritical = 20;
      percentageAction = 15;
      criticalPowerAction = "Hibernate";
    };
  };

  zramSwap.enable = true;
}
