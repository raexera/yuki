{config, ...}: {
  # Loads the acpi_call kernel module
  boot = {
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
  };

  # Configuration for auto-cpufreq, an automated CPU frequency scaling tool
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
    # Enable acpid service to handle ACPI events like button presses or power events
    acpid.enable = true;

    # Enable thermald service to automatically manage CPU temperature
    thermald.enable = true;

    # Enable throttled service to help mitigate Intel CPU throttling issues
    throttled.enable = true;

    # Enable upower for battery and power event handling
    upower.enable = true;
  };
}
