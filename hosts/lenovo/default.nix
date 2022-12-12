{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-ssd

    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./nvidia.nix

    ../shared
    ../shared/users/rxyhn.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "i915.force_probe=46a6"
      "i915.enable_psr=0"
      "i915.enable_guc=2"
      "i8042.direct"
      "i8042.dumbkbd"
    ];

    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        gfxmodeEfi = "1920x1080";
      };
    };
  };

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];

      displayManager = {
        defaultSession = "hyprland";
        gdm.enable = true;
        sessionPackages = [inputs.hyprland.packages.${pkgs.system}.default];
      };
    };

    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 0;
        STOP_CHARGE_THRESH_BAT0 = 85;
      };
    };

    acpid.enable = true;
    thermald.enable = true;
    upower.enable = true;
  };

  hardware = {
    enableRedistributableFirmware = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };

    bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };

    pulseaudio.enable = false;
  };

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
  };

  # compresses half the ram for use as swap
  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      inputs.xdg-portal-hyprland.packages.${pkgs.system}.default
    ];
  };

  security = {
    rtkit.enable = true;
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };

  environment.systemPackages = with pkgs; [
    acpi
    blueberry
    brightnessctl
    pavucontrol
    docker-client
    mesa
    polkit_gnome
    spice-gtk
    swtpm
    virt-manager
  ];

  virtualisation = {
    docker.enable = true;

    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        ovmf = {
          enable = true;
          packages = with pkgs; [OVMFFull.fd];
        };
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };

  system.stateVersion = lib.mkForce "22.11"; # DONT TOUCH THIS
}
