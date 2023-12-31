{
  config,
  pkgs,
  ...
}: {
  services.dunst = {
    enable = true;
    inherit (config.gtk) iconTheme;
  };
}
