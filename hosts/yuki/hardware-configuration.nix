{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot = {
    initrd = {
      availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod"];
      kernelModules = [];
    };

    kernelModules = ["kvm-intel"];
    extraModulePackages = [];

    extraModprobeConfig = ''
      blacklist nouveau
      options nouveau modeset=0
    '';

    kernelParams = ["module_blacklist=nouveau" "iommu=pt" "i915.enable_psr=0" "i8042.direct" "i8042.dumbkbd"];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NixOS-ROOT";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-label/NixOS-BOOT";
      fsType = "vfat";
    };
  };

  swapDevices = [{device = "/dev/disk/by-label/NixOS-SWAP";}];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
