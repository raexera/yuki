{pkgs, ...}: {
  config = {
    boot.initrd.kernelModules = ["xe"];

    environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";}; # Force intel-media-driver

    hardware.graphics = {
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
      ];
    };
  };
}
