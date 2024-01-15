{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkDefault versionOlder;
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

        open = mkDefault false;
        package = mkDefault config.boot.kernelPackages.nvidiaPackages.latest;

        powerManagement = {
          enable = mkDefault true;
          finegrained = mkDefault true;
        };
      };
    };

    services.xserver.videoDrivers = ["nvidia"];
  };
}
