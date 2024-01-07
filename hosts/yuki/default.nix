{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix

    ../modules/core
    ../modules/core/network.nix
    ../modules/core/ssh.nix

    ../modules/desktop
    ../modules/desktop/fonts.nix
    ../modules/desktop/greetd.nix
    ../modules/desktop/wayland.nix

    ../modules/programs/java.nix
    ../modules/programs/packages.nix

    ../modules/services/pipewire.nix
  ];

  boot = {
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = ["quiet" "splash"];

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
    };
  };

  hardware = {
    bluetooth = {
      enable = true;
      package = pkgs.bluez5-experimental;
    };

    enableAllFirmware = true;

    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        intel-ocl
        libvdpau-va-gl
        vaapiVdpau
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

    xserver.videoDrivers = ["nvidia"];
  };

  zramSwap.enable = true;
}
