{
  services = {
    flameshot = {
      enable = true;

      settings = {
        General = {
          disabledTrayIcon = true;
          showStartupLaunchMessage = false;
        };
      };
    };

    gpg-agent = {
      enable = true;
      pinentryFlavor = "gnome3";
      enableSshSupport = true;
      enableZshIntegration = true;
    };

    playerctld.enable = true;
  };
}
