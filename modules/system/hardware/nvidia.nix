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
in {
  config = {
    boot.blacklistedKernelModules = ["nouveau"];
    boot.initrd.kernelModules = ["nvidia"];
    boot.kernelParams = ["nvidia.NVreg_PreserveVideoMemoryAllocations=1"];

    hardware = {
      nvidia = {
        modesetting.enable = true;
        open = false;
        package = nvidiaPackage;

        powerManagement = {
          enable = true;
          finegrained = true;
        };

        prime.offload = {
          enable = mkIf (pCfg.nvidiaBusId != "" && (pCfg.intelBusId != "" || pCfg.amdgpuBusId != "")) true;
          enableOffloadCmd = mkIf pCfg.offload.enable true;
        };
      };

      nvidia-container-toolkit.enable = true;
    };
  };
}
