{
  pkgs,
  lib,
  ...
}: {
  documentation.dev.enable = true;
  environment.pathsToLink = ["/share/zsh"];

  i18n = {
    defaultLocale = "en_US.UTF-8";

    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
  };

  hardware.opengl.enable = true;

  programs = {
    less.enable = true;

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting = {
        enable = true;
        styles = {"alias" = "fg=magenta";};
        highlighters = ["main" "brackets" "pattern"];
      };
    };
  };

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = lib.mkDefault "23.11";

  time.timeZone = lib.mkDefault "Asia/Jakarta";

  users.users.rxyhn = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "adbusers"
      "docker"
      "input"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "video"
      "wheel"
    ];
  };

  zramSwap.enable = true;
}
