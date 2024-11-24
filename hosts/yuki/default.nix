{pkgs, ...}: {
  imports = [
    ./disk-configuration.nix
    ./hardware-configuration.nix
    ./power-management.nix

    ../modules/hardware/gpu/intel.nix
    ../modules/hardware/gpu/nvidia.nix
    ../modules/programs/dconf.nix
    ../modules/programs/gnupg.nix
    ../modules/programs/neovim.nix
    ../modules/programs/nh.nix
    ../modules/programs/thunar.nix
    ../modules/shell/zsh.nix
    ../modules/services/blueman.nix
    ../modules/services/dbus.nix
    ../modules/services/gnome-keyring.nix
    ../modules/services/greetd.nix
    ../modules/services/gvfs.nix
    ../modules/services/location.nix
    ../modules/services/mariadb.nix
    ../modules/services/networking.nix
    ../modules/services/openssh.nix
    ../modules/services/pipewire.nix
    ../modules/services/postgresql.nix
    ../modules/virtualisation/containers.nix
    ../modules/virtualisation/docker.nix
    ../modules/virtualisation/podman.nix
    ../modules/window-managers/hyprland.nix
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
    bluetooth = {
      enable = true;
      package = pkgs.bluez5-experimental;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
      };
    };

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
