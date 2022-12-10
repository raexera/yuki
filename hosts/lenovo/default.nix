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

  networking = {
    networkmanager.enable = true;
    useDHCP = false;
  };

  programs = {
    adb.enable = true;
    dconf.enable = true;

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    nm-applet.enable = true;
    seahorse.enable = true;
  };

  services = {
    acpid.enable = true;
    blueman.enable = true;

    dbus = {
      enable = true;
      packages = with pkgs; [dconf];
    };

    fwupd.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };

    thermald.enable = true;

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

    upower.enable = true;

    logind = {
      lidSwitch = "suspend";
      lidSwitchExternalPower = "lock";
    };
  };

  systemd.user.services = {
    pipewire.wantedBy = ["default.target"];
    pipewire-pulse.wantedBy = ["default.target"];
  };

  hardware = {
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
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
    bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };
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
    pam.services.swaylock.text = "auth include login";
    rtkit.enable = true;
  };

  environment.systemPackages = with pkgs; [
    acpi
    blueberry
    brightnessctl
    pavucontrol
    docker-client
    mesa
    polkit_gnome
    virt-manager
  ];

  time.hardwareClockInLocalTime = true;

  system.stateVersion = lib.mkForce "22.11"; # DONT TOUCH THIS
}
