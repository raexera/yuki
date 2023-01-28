{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.nixos.hardware.nvidia-sync;
in {
  options.modules.nixos.hardware.nvidia-sync = {
    enable = mkEnableOption "Enable the NVIDIA optimus prime sync mode";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      LIBVA_DRIVER_NAME = "nvidia";
      VDPAU_DRIVER = "nvidia";
      GBM_BACKEND = "nvidia-drm";
    };

    services.xserver.videoDrivers = ["nvidia"];

    hardware = {
      nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;

        prime = {
          sync.enable = true;
          nvidiaBusId = "PCI:1:0:0";
          intelBusId = "PCI:0:2:0";
        };
      };

      opengl.extraPackages = with pkgs; [
        libvdpau-va-gl
        vaapiVdpau
        nvidia-vaapi-driver
      ];
    };
  };
}
