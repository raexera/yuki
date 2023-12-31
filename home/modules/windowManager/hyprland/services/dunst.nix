{config, ...}: {
  services.dunst = {
    enable = true;
    inherit (config.gtk) iconTheme;
  };
}
