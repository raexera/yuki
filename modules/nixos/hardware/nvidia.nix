{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
    boot.blacklistedKernelModules = ["nouveau"];

    environment = {
      sessionVariables = {
        NVD_BACKEND = "direct";
        GBM_BACKEND = "nvidia-drm";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
        LIBVA_DRIVER_NAME = "nvidia";
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
        modesetting.enable = lib.mkDefault true;

        open = lib.mkDefault false;
        package = lib.mkDefault config.boot.kernelPackages.nvidiaPackages.latest;

        powerManagement = {
          enable = lib.mkDefault true;
          finegrained = lib.mkDefault true;
        };
      };
    };

    services.xserver.videoDrivers = ["nvidia"];
  };
}
