{
  config,
  lib,
  pkgs,
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
  boot.blacklistedKernelModules = ["nouveau"];
  environment.systemPackages = [nvidia-offload];
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

    opengl.extraPackages = lib.attrValues {
      inherit
        (pkgs)
        intel-media-driver
        libvdpau-va-gl
        vaapiIntel
        vaapiVdpau
        nvidia-vaapi-driver
        ;
    };
  };
}
