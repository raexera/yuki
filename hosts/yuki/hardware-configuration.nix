{
  config,
  lib,
  ...
}: {
  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = ["ideapad_laptop"];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];
  boot.kernelParams = ["nowatchdog"];
  boot.kernel.sysctl."vm.swappiness" = 10;

  hardware.enableRedistributableFirmware = lib.mkDefault true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
