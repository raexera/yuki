{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault;
in {
  imports = [
    ./hardware-configuration.nix

    ./modules/core
    ./modules/core/network.nix
    ./modules/core/ssh.nix

    ./modules/desktop
    ./modules/fonts.nix
    ./modules/greetd.nix
    ./modules/wayland.nix

    ./modules/programs/java.nix
    ./modules/programs/packages.nix

    ./modules/services/pipewire.nix
  ];

  boot = {
    kernelModules = ["acpi_call"];
    blacklistedKernelModules = ["nouveau"];
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
      "quiet"
      "splash"
      "iommu=pt"
      "i8042.direct"
      "i8042.dumbkbd"
      "i915.enable_psr=0"
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
      pciutils
    ];

    variables = {
      GDK_SCALE = "2";
      NVD_BACKEND = "direct";
      MOZ_DISABLE_RDD_SANDBOX = "1";
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      package = pkgs.bluez5-experimental;
    };

    enableAllFirmware = mkDefault true;

    nvidia = {
      package = mkDefault config.boot.kernelPackages.nvidiaPackages.beta;
      modesetting.enable = mkDefault true;
      powerManagement.enable = mkDefault true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = mkDefault "PCI:0:2:0";
        nvidiaBusId = mkDefault "PCI:1:0:0";
      };
    };

    opengl = {
      enable = mkDefault true;
      driSupport = mkDefault true;
      driSupport32Bit = mkDefault true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-ocl
        libvdpau-va-gl
        vaapiVdpau
        nvidia-vaapi-driver
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
        libvdpau-va-gl
        vaapiVdpau
        glxinfo
        vdpauinfo
      ];
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
