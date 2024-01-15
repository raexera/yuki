{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault versionOlder;

  nvStable = config.boot.kernelPackages.nvidiaPackages.stable.version;
  nvBeta = config.boot.kernelPackages.nvidiaPackages.beta.version;

  nvidiaPackage =
    if (versionOlder nvBeta nvStable)
    then config.boot.kernelPackages.nvidiaPackages.stable
    else config.boot.kernelPackages.nvidiaPackages.beta;
in {
  config = {
    boot.blacklistedKernelModules = ["nouveau"];

    environment = {
      sessionVariables = {
        NVD_BACKEND = "direct";
        WLR_NO_HARDWARE_CURSORS = "1";
      };

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

        nvidiaSettings = true;
        nvidiaPersistenced = true;

        open = mkDefault false;
        package = mkDefault nvidiaPackage;

        powerManagement = {
          enable = mkDefault true;
          finegrained = mkDefault true;
        };
      };
    };

    services.xserver.videoDrivers = ["nvidia"];
  };
}
