{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/shared
    ../common/users/rxyhn

    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };

    systemd-boot.enable = false;

    grub = {
      enable = true;
      version = 2;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      enableCryptodisk = true;
      configurationLimit = 3;
      gfxmodeEfi = "1920x1080";
      theme = pkgs.fetchzip {
        # https://github.com/AdisonCavani/distro-grub-themes
        url = "https://raw.githubusercontent.com/AdisonCavani/distro-grub-themes/master/themes/lenovo.tar";
        hash = "sha256-6ZevSnSNJ/Q67DTNJj8k4pjOjWZFj0tG0ljG3gwbLuc=";
        stripRoot = false;
      };
    };
  };

  hardware = {
    enableRedistributableFirmware = true;

    bluetooth = {
      enable = true;
      package = pkgs.bluez;
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  networking = {
    hostName = "lenovo";
    networkmanager.enable = true;
    useDHCP = false;
  };

  services = {
    acpid.enable = true;
    blueman.enable = true;
    upower.enable = true;

    xserver = {
      enable = true;
      displayManager = {
        autoLogin = {
          enable = true;
          user = "rxyhn";
        };

        defaultSession = "none+awesome";
        lightdm.enable = true;
      };

      dpi = 144;
      exportConfiguration = true;
      layout = "us";

      libinput = {
        enable = true;
        touchpad = {naturalScrolling = true;};
      };

      windowManager = {
        awesome = {
          enable = true;

          luaModules = lib.attrValues {
            inherit (pkgs.luaPackages) lgi ldbus luadbi-mysql luaposix;
          };
        };
      };
    };

    logind.lidSwitch = "suspend";
    thermald.enable = true;

    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 80;
        STOP_CHARGE_THRESH_BAT0 = 85;
      };
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
