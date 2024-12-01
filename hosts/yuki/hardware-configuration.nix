{lib, ...}: {
  boot = {
    initrd = {
      availableKernelModules = ["nvme" "sd_mod" "thunderbolt" "usb_storage" "xhci_pci"];
      kernelModules = ["ideapad_laptop"];
    };
    kernelModules = ["kvm-intel"];
    kernelParams = ["nowatchdog"];
  };

  hardware.enableRedistributableFirmware = lib.mkDefault true;

  # √(3072² + 1920²) px / 14.5 in ≃ 250 dpi
  services.xserver.dpi = 250;
}
