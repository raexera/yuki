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
    boot.blacklistedKernelModules = ["nouveau"];

    environment = {
      sessionVariables.NVD_BACKEND = "direct";

      systemPackages = with pkgs; [
        libva
        libva-utils
        mesa
        vulkan-tools
        vulkan-loader
        vulkan-validation-layers
        vulkan-extension-layer
      ];
    };

    hardware = {
      nvidia = {
        modesetting.enable = mkDefault true;

        nvidiaPersistenced = true;
        nvidiaSettings = false;

        open = mkDefault false;
        package = mkDefault nvidiaPackage;

        powerManagement = {
          enable = mkDefault true;
          finegrained = mkDefault true;
        };

        prime.offload = {
          enable = mkIf (pCfg.nvidiaBusId != "" && (pCfg.intelBusId != "" || pCfg.amdgpuBusId != "")) true;
          enableOffloadCmd = mkIf pCfg.offload.enable true;
        };
      };
    };

    services.xserver.videoDrivers = ["nvidia"];
  };
}
