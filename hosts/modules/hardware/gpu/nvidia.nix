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
      kernelModules = [
        "nvidia"
        "nvidia_modeset"
        "nvidia_drm"
        "nvidia_uvm"
      ];

      blacklistedKernelModules = ["nouveau"];
    };

    environment.variables = {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
    };

    hardware.nvidia = {
      package = nvidiaPackage;
      open = false;
      modesetting.enable = true;
      powerManagement.enable = true;
      prime.offload = {
        enable = mkIf (pCfg.nvidiaBusId != "" && (pCfg.intelBusId != "" || pCfg.amdgpuBusId != "")) true;
        enableOffloadCmd = mkIf pCfg.offload.enable true;
      };
    };
  };
}
