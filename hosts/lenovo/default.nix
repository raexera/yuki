{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../shared

    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];

    initrd = {
      systemd.enable = true;
      supportedFilesystems = ["btrfs"];
    };

    kernelModules = ["acpi_call"];

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
  };

  environment = {
    variables = {
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "0.5";
    };

    systemPackages = lib.attrValues {
      inherit
        (pkgs)
        acpi
        arandr
        blueberry
        brightnessctl
        libva
        libva-utils
        ocl-icd
        slop
        vulkan-loader
        vulkan-validation-layers
        vulkan-tools
        ;
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
    btrfs.autoScrub.enable = true;
    thermald.enable = true;
    upower.enable = true;

    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 0; # dummy value
        STOP_CHARGE_THRESH_BAT0 = 1; # battery conservation mode
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      };
    };

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
          package = inputs.nixpkgs-f2k.packages.${pkgs.system}.awesome-git;

          luaModules = lib.attrValues {
            inherit (pkgs.luaPackages) lgi ldbus luadbi-mysql luaposix;
          };
        };
      };
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
