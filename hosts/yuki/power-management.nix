{config, ...}: {
  boot = {
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
  };

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services = {
    acpid.enable = true;

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

    thermald.enable = true;

    throttled.enable = true;

    upower.enable = true;
  };
}
