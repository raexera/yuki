{config, ...}: {
  boot = {
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [
      acpi_call
      cpupower
    ];
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
    thermald.enable = true;

    acpid = {
      enable = true;
      logEvents = true;
    };

    upower = {
      enable = true;
      percentageLow = 20;
      percentageCritical = 15;
      percentageAction = 10;
      criticalPowerAction = "Hibernate";
    };
  };
}
