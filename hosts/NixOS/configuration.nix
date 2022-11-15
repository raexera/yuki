{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 5d";
    };
    package = pkgs.nixUnstable;

    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
    settings = {
      auto-optimise-store = true;
      allowed-users = ["rxyhn"];
      max-jobs = 6;

      # use binary cache, its not gentoo
      substituters = [
        "https://cache.nixos.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://hyprland.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  # faster rebuilding
  documentation = {
    enable = false;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
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
      };
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    kitty
    git
  ];

  programs = {
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services = {
    xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
      layout = "us";
    };
    printing.enable = true;
    xserver.libinput.enable = true;
    openssh.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
      driSupport = true;
      driSupport32Bit = true;
    };
    bluetooth.enable = true;
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [443 80 22];
      allowedUDPPorts = [443 80];
      allowPing = false;
      logReversePathDrops = true;
    };

    hostName = "NixOS";
    networkmanager.enable = true;
  };

  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;

  users.users.rxyhn = {
    isNormalUser = true;
    home = "/home/rxyhn";
    description = "Rayhan Pratama";
    shell = pkgs.zsh;
    extraGroups = ["wheel" "networkmanager"];
  };

  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  security = {
    protectKernelImage = true;
    lockKernelModules = false;
    rtkit.enable = true;
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };
    # this is required for swaylock to work
    pam.services = {
      login.enableGnomeKeyring = true;
      swaylock = {
        text = ''
          auth include login
        '';
      };
    };
    # allow shutdown/reboot without password
    sudo = {
      execWheelOnly = true;
      extraConfig = ''
        ALL ALL = (root) NOPASSWD: ${pkgs.systemd}/bin/shutdown
        ALL ALL = (root) NOPASSWD: ${pkgs.systemd}/bin/reboot '';
    };
  };

  system.stateVersion = "22.05";
}
