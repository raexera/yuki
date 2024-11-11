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
    kernel.sysctl."vm.swappiness" = 10;
  };

  hardware = {
    enableRedistributableFirmware = lib.mkDefault true;
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
