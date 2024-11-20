{config, ...}: {
  boot = {
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
  };

  services = {
    # Enable acpid service to handle ACPI events like button presses or power events
    acpid.enable = true;

    # Enable auto-cpufreq, an automated CPU frequency scaling tool
    auto-cpufreq = {
      enable = true;
      settings = {
        charger = {
          governor = "performance";
          energy_performance_preference = "performance";
          turbo = "auto";
        };
        battery = {
          governor = "powersave";
          energy_performance_preference = "power";
          turbo = "auto";
        };
      };
    };

    # Enable thermald service to automatically manage CPU temperature
    thermald.enable = true;

    # Enable throttled service to help mitigate Intel CPU throttling issues
    throttled.enable = true;

    # Enable upower for battery and power event handling
    upower.enable = true;
  };
}
