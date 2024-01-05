{
  pkgs,
  lib,
  ...
}: {
  documentation.dev.enable = true;

  environment.pathsToLink = ["/share/zsh"];

  programs = {
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';

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

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
  };
  security.sudo.wheelNeedsPassword = false;

  time = {
    timeZone = lib.mkDefault "Asia/Jakarta";
    hardwareClockInLocalTime = lib.mkDefault true;
  };

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

  system.stateVersion = lib.mkDefault "23.11";
}
