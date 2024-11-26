{
  config,
  lib,
  ...
}: {
  boot = {
    initrd = {
      availableKernelModules = ["nvme" "sd_mod" "thunderbolt" "usb_storage" "xhci_pci"];
      kernelModules = ["ideapad_laptop"];
    };
    kernelModules = ["kvm-intel"];
    kernelParams = ["nowatchdog"];
    kernel.sysctl = {
      "vm.swappiness" = 180;
      "vm.watermark_boost_factor" = 0;
      "vm.watermark_scale_factor" = 125;
      "vm.page-cluster" = 0;
    };
  };

  hardware = {
    enableRedistributableFirmware = lib.mkDefault true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  # √(3072² + 1920²) px / 14.5 in ≃ 250 dpi
  services.xserver.dpi = 250;

  zramSwap = {
    enable = true;
    memoryPercent = 50;
    priority = 100;
    algorithm = "zstd";
  };
}
