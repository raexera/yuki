{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.nixos.hardware.nvidia.only;
in {
  options.modules.nixos.hardware.nvidia.only = {
    enable = mkEnableOption "Enable The NVIDIA Driver";
  };

  config = mkIf cfg.enable {
    environment = {
      variables = {
        LIBVA_DRIVER_NAME = "nvidia";
        VDPAU_DRIVER = "nvidia";
        __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      };
    };

    boot.initrd.kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];
    services.xserver.videoDrivers = ["nvidia"];

    hardware = {
      nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;
      };

      opengl.extraPackages = with pkgs; [nvidia-vaapi-driver];
    };
  };
}
