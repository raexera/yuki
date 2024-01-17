{
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.bibata-cursors];

  programs.dconf.profiles = {
    gdm.databases = [
      {
        lockAll = true;
        settings = {
          "org/gnome/desktop/peripherals/touchpad".tap-to-click = true;

          "org/gnome/desktop/interface" = {
            cursor-size = lib.gvariant.mkInt32 24;
            cursor-theme = "Bibata-Modern-Classic";
          };
        };
      }
    ];
  };

  security = {
    pam.services = {
      gdm = {
        gnupg.enable = true;
        enableGnomeKeyring = true;
      };
    };
  };

  services.xserver = {
    enable = true;
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };
  };
}
