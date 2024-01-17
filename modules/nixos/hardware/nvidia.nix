{
  config,
  lib,
  pkgs,
  ...
}: {
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
        modesetting.enable = lib.mkDefault true;

        nvidiaPersistenced = true;
        nvidiaSettings = false;

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
