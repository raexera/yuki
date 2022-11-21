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

  nixpkgs.overlays = [inputs.nixpkgs-f2k.overlays.window-managers];

  services.xserver = {
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

    dpi = 216;
    exportConfiguration = true;
    layout = "us";

    libinput = {
      enable = true;

      touchpad = {
        accelSpeed = "0.4";
        naturalScrolling = true;
      };
    };

    windowManager.awesome = {
      enable = true;
      package = pkgs.awesome-git;
      luaModules = with pkgs.lua52Packages; [
        lgi
        ldbus
        luarocks-nix
        luadbi-mysql
        luaposix
      ];
    };
  };

  security = {
    rtkit.enable = true;
  };
}
