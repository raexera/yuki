{
  config,
  pkgs,
  ...
}: {
  services.swaync = {
    enable = true;
    systemd.enable = true;
  };
}
