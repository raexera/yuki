{
  config,
  pkgs,
  ...
}: {
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

  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
  };
}
