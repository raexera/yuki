{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) mkIf mkDefault versionOlder;

  nvStable = config.boot.kernelPackages.nvidiaPackages.stable.version;
  nvBeta = config.boot.kernelPackages.nvidiaPackages.beta.version;

  nvidiaPackage =
    if (versionOlder nvBeta nvStable)
    then config.boot.kernelPackages.nvidiaPackages.stable
    else config.boot.kernelPackages.nvidiaPackages.beta;
in {
  config = {
    boot.initrd.kernelModules = ["nvidia"];
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
        open = mkDefault false;
        package = mkDefault nvidiaPackage;
        modesetting.enable = mkDefault true;

        powerManagement = {
          enable = mkDefault true;
          finegrained = mkDefault false;
        };

        prime = {
          offload = {
            enable = mkDefault true;
            enableOffloadCmd = mkIf config.hardware.nvidia.prime.offload.enable true;
          };

          reverseSync.enable = mkDefault true;
        };
      };

      opengl = {
        extraPackages = with pkgs; [vaapiVdpau nvidia-vaapi-driver];
        extraPackages32 = with pkgs.pkgsi686Linux; [vaapiVdpau nvidia-vaapi-driver];
      };
    };

    services.xserver.videoDrivers = ["nvidia"];
  };
}
