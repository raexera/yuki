{pkgs, ...}: {
  security = {
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [pkgs.apparmor-profiles];
    };

    pam = {
      loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
      ];

      services = {
        lightdm.enableGnomeKeyring = true;
        login.enableGnomeKeyring = true;
      };
    };

    polkit.enable = true;
    rtkit.enable = true;
  };
}
