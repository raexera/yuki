{pkgs, ...}: {
  config = {
    boot = {
      initrd.kernelModules = ["i915"];

      extraModprobeConfig = ''
        options i915 enable_guc=3
        options i915 enable_psr=0
        options i915 force_probe=46a6
      '';
    };

    environment.sessionVariables = {LIBVA_DRIVER_NAME = "iHD";};

    hardware.graphics = {
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
      ];
    };
  };
}
