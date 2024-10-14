{pkgs, ...}: {
  config = {
    boot.initrd.kernelModules = ["i915"];

    hardware = {
      graphics = {
        extraPackages = with pkgs; [
          intel-compute-runtime
          intel-media-driver
        ];
      };
    };
  };
}
