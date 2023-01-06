{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.nixos.bootloader.grub;
in {
  options.modules.nixos.bootloader.grub = {
    enable = mkEnableOption "Enable The Grub Bootloader";

    efiSysMountPoint = mkOption {
      type = types.str;
      default = "/boot";
      description = "The mount point of the EFI System Partition";
    };

    device = mkOption {
      type = types.str;
      default = "nodev";
      description = "The device to install grub to";
    };

    useOSProber = mkOption {
      type = types.bool;
      default = true;
      description = "Whether to use os-prober to detect other operating systems";
    };
  };

  config = mkIf cfg.enable {
    boot.loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "${cfg.efiSysMountPoint}";
      };

      systemd-boot.enable = false;

      grub = {
        enable = true;
        version = 2;
        device = "${cfg.device}";
        efiSupport = true;
        useOSProber = cfg.useOSProber;
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
}
