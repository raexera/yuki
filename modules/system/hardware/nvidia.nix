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
    boot = {
      kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
      blacklistedKernelModules = ["nouveau"];
    };

    environment.sessionVariables = {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    hardware = {
      nvidia = {
        open = false;
        package = nvidiaPackage;

        modesetting.enable = true;
        powerManagement.enable = true;

        prime.offload = {
          enable = mkIf (pCfg.nvidiaBusId != "" && (pCfg.intelBusId != "" || pCfg.amdgpuBusId != "")) true;
          enableOffloadCmd = mkIf pCfg.offload.enable true;
        };
      };

      nvidia-container-toolkit.enable = true;
    };
  };
}
