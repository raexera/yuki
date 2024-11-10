{
  imports = [
    ./disk-configuration.nix
    ./hardware-configuration.nix
    ./power-management.nix
    ../../modules/config
    ../../modules/environment
    ../../modules/hardware/bluetooth.nix
    ../../modules/hardware/intel.nix
    ../../modules/hardware/nvidia.nix
    ../../modules/hardware/ssd.nix
    ../../modules/programs
    ../../modules/programs/hyprland.nix
    ../../modules/security
    ../../modules/services
    ../../modules/services/greetd.nix
    ../../modules/system
    ../../modules/system/boot.nix
    ../../modules/virtualisation
  ];

  disko.devices.disk.main.device = "/dev/nvme0n1";

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  services = {
    fwupd.enable = true;
    hardware.bolt.enable = true;
  };

  # Intel Core i7-12700H (Alder Lake)
  boot.kernelParams = ["i915.force_probe=46a6"];

  # NVIDIA GeForce RTX 3050 Mobile (Ampere)
  services.xserver.videoDrivers = ["nvidia"];
}
