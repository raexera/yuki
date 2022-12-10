{
  config,
  pkgs,
  lib,
  ...
}: let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in {
  environment = {
    systemPackages = [nvidia-offload];
    variables = {
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };

  services.xserver.videoDrivers = ["nvidia"];
  boot.blacklistedKernelModules = ["nouveau"];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      nvidiaPersistenced = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.production;
      prime = {
        offload.enable = true;
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };
    opengl.extraPackages = with pkgs; [nvidia-vaapi-driver];
  };
}
