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

    ../modules/hardware/bluetooth
    ../modules/hardware/gpu/intel
    ../modules/hardware/gpu/nvidia
    ../modules/window-managers/hyprland
  ];

  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  environment.systemPackages = with pkgs; [
    # Communication
    discord
    tdesktop
    slack

    # Media & Music
    youtube-music
    amberol
    celluloid
    imv
    loupe
    pavucontrol

    # Office & Reading
    onlyoffice-bin
    foliate

    # Productivity
    obsidian
  ];

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
    fstrim.enable = true;
    fwupd.enable = true;
    hardware.bolt.enable = true;
  };

  # Intel Core i7-12700H (Alder Lake)
  boot.kernelParams = ["i915.force_probe=46a6"];

  # NVIDIA GeForce RTX 3050 Mobile (Ampere)
  services.xserver.videoDrivers = ["nvidia"];
}
