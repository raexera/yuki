{
  config,
  pkgs,
  ...
}: let
  theme = import ../../theme/theme.nix {};
in {
  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Asia/Jakarta";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = ["en_US.UTF-8/UTF-8"];
  };

  console = let
    normal = with theme.colors; [bg c1 c2 c3 c4 c5 c6 c7];
    bright = with theme.colors; [lbg c9 c10 c11 c12 c13 c14 c15];
  in {
    colors = normal ++ bright;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
  };

  programs = {
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';

    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    npm = {
      enable = true;
      npmrc = ''
        prefix = ''${HOME}/.npm
        color = true
      '';
    };

    java = {
      enable = true;
      package = pkgs.jdk;
    };
  };

  services = {
    dbus = {
      packages = with pkgs; [dconf];
      enable = true;
    };

    udev.packages = with pkgs; [gnome.gnome-settings-daemon];

    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';
  };

  environment.variables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    fzf
  ];
}
