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

  nixpkgs.overlays = [inputs.nixpkgs-f2k.overlays.window-managers];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    windowManager.awesome = {
      enable = true;
      package = pkgs.awesome-git;
      luaModules = [];
    };
  };

  security = {
    rtkit.enable = true;
  };
}
