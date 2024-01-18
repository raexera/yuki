{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault mkIf versionOlder;

  nvStable = config.boot.kernelPackages.nvidiaPackages.stable.version;
  nvBeta = config.boot.kernelPackages.nvidiaPackages.beta.version;

  nvidiaPackage =
    if (versionOlder nvBeta nvStable)
    then config.boot.kernelPackages.nvidiaPackages.stable
    else config.boot.kernelPackages.nvidiaPackages.beta;

  pCfg = config.hardware.nvidia.prime;
in {
  config = {
    boot.blacklistedKernelModules = mkDefault ["nouveau"];

    environment = {
      sessionVariables = {
        NVD_BACKEND = "direct";
      };
    };

    hardware = {
      nvidia = {
        powerManagement = {
          enable = mkDefault true;
          finegrained = mkDefault true;
        };

        dynamicBoost.enable = mkDefault true;
        modesetting.enable = mkDefault true;

        prime.offload = {
          enable = mkIf (pCfg.nvidiaBusId != "" && (pCfg.intelBusId != "" || pCfg.amdgpuBusId != "")) true;
          enableOffloadCmd = mkIf pCfg.offload.enable true;
        };

        nvidiaSettings = mkDefault false;
        nvidiaPersistenced = mkDefault true;

        package = mkDefault nvidiaPackage;
        open = mkDefault false;
      };
    };

    services.xserver.videoDrivers = mkDefault ["nvidia"];
  };
}
