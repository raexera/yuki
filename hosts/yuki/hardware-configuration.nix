{
  config,
  lib,
  ...
}: {
  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = ["dm-snapshot" "ideapad_laptop"];
  boot.kernelModules = ["kvm-intel"];
  boot.blacklistedKernelModules = ["nouveau"];
  boot.kernelParams = ["i915.force_probe=46a6"];

  hardware.enableAllFirmware = lib.mkDefault true;
  hardware.enableRedistributableFirmware = lib.mkDefault true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
