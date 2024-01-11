{pkgs, ...}: {
  config = {
    boot.initrd.kernelModules = ["i915"];

    hardware = {
      opengl = {
        extraPackages = with pkgs; [libvdpau-va-gl intel-media-driver intel-ocl];
        extraPackages32 = with pkgs.pkgsi686Linux; [libvdpau-va-gl intel-media-driver];
      };
    };
  };
}
