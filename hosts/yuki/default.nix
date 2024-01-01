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
    initrd.kernelModules = [
      "i915"
      "nvidia"
      "nvidia_modeset"
      "nvidia_uvm"
      "nvidia_drm"
      "ideapad_laptop"
    ];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "i8042.direct"
      "i8042.dumbkbd"
      "i915.enable_psr=0"
      "iommu=pt"
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
      glxinfo
      libva
      libva-utils
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
    ];

    variables = {
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      GDK_SCALE = "2";
      MOZ_DISABLE_RDD_SANDBOX = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };

  hardware = {
    enableAllFirmware = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime
        nvidia-vaapi-driver
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [vaapiIntel];
    };

    nvidia = {
      modesetting.enable = mkDefault true;
      powerManagement.enable = mkDefault true;
      open = mkDefault false;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = mkDefault "PCI:0:2:0";
        nvidiaBusId = mkDefault "PCI:1:0:0";
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

    xserver.videoDrivers = mkDefault ["nvidia"];
  };

  zramSwap.enable = true;
}
