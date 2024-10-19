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
        yuki = {
          device = "/dev/disk/by-uuid/dd3b871e-d7ef-40af-a1e3-d63c26c76662";
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
      "nvidia"
      "modesetting"
    ];
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
