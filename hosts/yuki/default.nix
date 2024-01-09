{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

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
    enableRedistributableFirmware = true;

    nvidia.prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [glxinfo vdpauinfo];
    };
  };

  networking.hostName = "yuki";

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

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
  };

  zramSwap.enable = true;
}
