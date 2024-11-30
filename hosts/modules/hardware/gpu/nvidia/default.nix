{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkDefault versionOlder;

  # Use the latest possible nvidia package
  nvStable = config.boot.kernelPackages.nvidiaPackages.stable.version;
  nvBeta = config.boot.kernelPackages.nvidiaPackages.beta.version;

  nvidiaPackage =
    if (versionOlder nvBeta nvStable)
    then config.boot.kernelPackages.nvidiaPackages.stable
    else config.boot.kernelPackages.nvidiaPackages.beta;

  pCfg = config.hardware.nvidia.prime;
in {
  boot = {
    kernelModules = [
      "nvidia"
      "nvidia_modeset"
      "nvidia_drm"
      "nvidia_uvm"
    ];

    blacklistedKernelModules = ["nouveau"];
  };

  environment.sessionVariables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
  };

  hardware.nvidia = {
    package = mkDefault nvidiaPackage;
    open = mkDefault false;

    powerManagement.enable = mkDefault true;
    dynamicBoost.enable = mkDefault true;
    modesetting.enable = mkDefault true;

    prime.offload = {
      enable = mkIf (pCfg.nvidiaBusId != "" && (pCfg.intelBusId != "" || pCfg.amdgpuBusId != "")) true;
      enableOffloadCmd = mkIf pCfg.offload.enable true;
    };
  };
}
