{
  imports = [
    ./disk-configuration.nix
    ./hardware-configuration.nix
  ];

  disko.devices.disk.main.device = "/dev/nvme0n1";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  programs.auto-cpufreq = {
    enable = true;
    settings = {
      # See available governors: `cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors`
      # See available preferences: `cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_available_preferences`
      charger = {
        governor = "performance";
        energy_performance_preference = "performance";
        turbo = "auto";
      };
      battery = {
        governor = "powersave";
        energy_performance_preference = "power";
        turbo = "auto";

        enable_thresholds = true;
        ideapad_laptop_conservation_mode = true;
      };
    };
  };

  services = {
    fwupd.enable = true;
    hardware.bolt.enable = true;
    thermald.enable = true;

    acpid = {
      enable = true;
      logEvents = true;
    };

    logind = {
      lidSwitch = "suspend-then-hibernate";
      lidSwitchDocked = "ignore";
      lidSwitchExternalPower = "suspend-then-hibernate";
    };

    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 15;
      percentageAction = 10;
      criticalPowerAction = "Hibernate";
    };
  };

  # Intel Core i7-12700H (Alder Lake)
  boot.kernelParams = ["i915.force_probe=46a6"];

  # NVIDIA GeForce RTX 3050 Mobile (Ampere)
  services.xserver.videoDrivers = ["nvidia"];
}
