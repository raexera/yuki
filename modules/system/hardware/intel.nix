{pkgs, ...}: {
  config = {
    boot.initrd.kernelModules = ["i915" "xe"];

    hardware.graphics = {
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
      ];
    };
  };
}
