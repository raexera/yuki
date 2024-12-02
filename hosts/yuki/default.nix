{pkgs, ...}: {
  imports = [
    ./disk-configuration.nix
    ./hardware-configuration.nix
    ./power-management.nix

    ./programs/dconf.nix
    ./programs/gnupg.nix
    ./programs/thunar.nix
    ./services/blueman.nix
    ./services/dbus.nix
    ./services/gnome-keyring.nix
    ./services/greetd.nix
    ./services/gvfs.nix
    ./services/mariadb.nix
    ./services/pipewire.nix
    ./services/postgresql.nix
    ./virtualisation/containers.nix
    ./virtualisation/docker.nix
    ./virtualisation/podman.nix

    ../config/fonts
    ../config/hardware/acpi_call
    ../config/hardware/bluetooth
    ../config/hardware/cpu/intel
    ../config/hardware/gpu/intel
    ../config/hardware/gpu/nvidia
    ../config/hardware/ssd
    ../config/window-managers/hyprland
  ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    nvidia = {
      prime = {
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };

    nvidia-container-toolkit.enable = true;
  };

  services = {
    btrfs.autoScrub.enable = true;

    fwupd.enable = true;

    hardware.bolt.enable = true;
  };

  # Intel Core i7-12700H (Alder Lake)
  boot.kernelParams = ["i915.force_probe=46a6" "i915.enable_guc=3"];

  # NVIDIA GeForce RTX 3050 Mobile (Ampere)
  services.xserver.videoDrivers = ["nvidia"];
}
