# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
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
