{
  security = {
    pam.services = {
      login = {
        enableGnomeKeyring = true;
        gnupg = {
          enable = true;
          noAutostart = true;
          storeOnly = true;
        };
      };
    };

    sudo.wheelNeedsPassword = false;
  };
}
