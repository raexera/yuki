{config, ...}: {
  environment.systemPackages = with config.boot.kernelPackages; [cpupower];

  powerManagement.powertop.enable = true;

  services = {
    acpid.enable = true;

    thermald.enable = true;

    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        START_CHARGE_THRESH_BAT0 = 0;
        STOP_CHARGE_THRESH_BAT0 = 1; # battery conservation mode
      };
    };

    upower.enable = true;
  };
}
