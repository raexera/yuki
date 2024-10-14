{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf versionOlder;

  nvStable = config.boot.kernelPackages.nvidiaPackages.stable.version;
  nvBeta = config.boot.kernelPackages.nvidiaPackages.beta.version;
  nvidiaPackage =
    if (versionOlder nvBeta nvStable)
    then config.boot.kernelPackages.nvidiaPackages.stable
    else config.boot.kernelPackages.nvidiaPackages.beta;

  pCfg = config.hardware.nvidia.prime;

  extraEnv = {
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };
in {
  config = {
    boot.blacklistedKernelModules = ["nouveau"];
    boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];

    environment.variables = extraEnv;
    environment.sessionVariables = extraEnv;

    hardware = {
      nvidia = {
        powerManagement = {
          enable = true;
          finegrained = true;
        };

        dynamicBoost.enable = true;
        modesetting.enable = true;

        prime.offload = {
          enable = mkIf (pCfg.nvidiaBusId != "" && (pCfg.intelBusId != "" || pCfg.amdgpuBusId != "")) true;
          enableOffloadCmd = mkIf pCfg.offload.enable true;
        };

        nvidiaSettings = false;
        nvidiaPersistenced = true;

        package = nvidiaPackage;
        open = false;
      };
    };

    services.xserver.videoDrivers = ["nvidia"];
  };
}
