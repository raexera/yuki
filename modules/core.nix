{
  pkgs,
  lib,
  ...
}: {
  documentation.dev.enable = true;
  environment.pathsToLink = ["/share/zsh"];
  environment.systemPackages = with pkgs;
    [
      git
      starship
      vim
      neovim

      (python3.withPackages (p:
        with p; [
          pygobject3
        ]))
    ]
    ++ [
      gobject-introspection
      pipenv
    ];

  console = let
    normal = ["1E1E2E" "F38BA8" "A6E3A1" "F9E2AF" "89B4FA" "F5C2E7" "94E2D5" "BAC2DE"];
    bright = ["313244" "F38BA8" "A6E3A1" "F9E2AF" "89B4FA" "F5C2E7" "94E2D5" "A6ADC8"];
  in {
    colors = normal ++ bright;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    useXkbConfig = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
  };

  programs = {
    less.enable = true;

    java = {
      enable = true;
      package = pkgs.jre;
    };

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

  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = lib.mkDefault "23.11";

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
}
