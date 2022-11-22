{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nvidia.nix
  ];

  environment = {
    loginShellInit = ''
      dbus-update-activation-environment --systemd DISPLAY
      eval $(ssh-agent)
      eval $(gnome-keyring-daemon --start)
      export GPG_TTY=$TTY
    '';

    systemPackages = with pkgs; [
      lua
    ];
  };

  services = {
    xserver = {
      enable = true;

      displayManager = {
        autoLogin = {
          enable = true;
          user = "rxyhn";
        };
        defaultSession = "none+awesome";
        lightdm = {
          enable = true;
        };
      };

      dpi = 192;
      exportConfiguration = true;
      layout = "us";

      libinput = {
        enable = true;
        touchpad = {
          accelSpeed = "0.4";
          naturalScrolling = true;
        };
      };

      windowManager = {
        awesome = {
          enable = true;
          luaModules = with pkgs.lua52Packages; [
            lgi
            ldbus
            luarocks-nix
            luadbi-mysql
            luaposix
          ];
        };
      };
    };

    picom = {
      enable = true;
      backend = "glx";
      vSync = true;
      shadow = true;
      shadowOffsets = [(-40) (-40)];
      shadowOpacity = 0.40;

      shadowExclude = [
        "class_g = 'slop'"
        "window_type = 'menu'"
        "window_type = 'dock'"
        "window_type = 'desktop'"
        "class_g = 'Firefox' && window_type *= 'utility'"
        "_GTK_FRAME_EXTENTS@:c"
      ];

      opacityRules = [
        "70:class_g = 'splash'"
      ];

      wintypes = {
        popup_menu = {full-shadow = true;};
        dropdown_menu = {full-shadow = true;};
        notification = {full-shadow = true;};
        normal = {full-shadow = true;};
      };

      settings = {
        shadow-radius = 40;
        use-damage = true;

        corner-radius = 8;
        rounded-corners-exclude = [
          "!window_type = 'normal' && !window_type = 'dialog'"
        ];

        blur-method = "dual_kawase";
        blur-strength = 7.0;
        kernel = "11x11gaussian";
        blur-background = false;
        blur-background-frame = true;
        blur-background-fixed = true;

        blur-background-exclude = [
          "!window_type = 'splash'"
        ];
      };
    };
  };

  security = {
    rtkit.enable = true;
  };

  system.stateVersion = "22.05"; # DONT TOUCH THIS
}
