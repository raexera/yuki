{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

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
    hostName = "NixOS";
    networkmanager.enable = true;
  };
  
  users.users.rxyhn = {
    isNormalUser = true;
    home  = "/home/rxyhn";
    description  = "Rayhan Pratama";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "22.05";
}
