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
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    windowManager.awesome = {
      enable = true;
      package = pkgs.awesome;
      luaModules = [];
    };
  };

  security = {
    rtkit.enable = true;
  };
}
