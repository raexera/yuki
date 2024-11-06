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

    hardware.graphics = {
      extraPackages = with pkgs; [
        intel-media-driver
        intel-compute-runtime
        vpl-gpu-rt
      ];
      extraPackages32 = with pkgs.driversi686Linux; [
        intel-media-driver
      ];
    };
  };
}
