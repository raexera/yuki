{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.hardware.nvidia;

  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in {
  options.modules.hardware.nvidia = {
    enable = mkEnableOption "Enable The NVIDIA Optimus Prime Offload";
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = [nvidia-offload];

      variables = {
        LIBVA_DRIVER_NAME = "iHD";
        VDPAU_DRIVER = "va_gl";
      };
    };

    boot.initrd.kernelModules = ["nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm"];

    services.xserver.videoDrivers = ["nvidia"];

    hardware = {
      nvidia = {
        modesetting.enable = true;
        powerManagement = {
          enable = true;
          finegrained = true;
        };

        prime = {
          offload.enable = true;
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
        };
      };

      opengl.extraPackages = with pkgs; [nvidia-vaapi-driver];
    };
  };
}
