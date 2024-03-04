{config, ...}: {
  virtualisation.docker = {
    enable = true;
    enableNvidia = builtins.any (driver: driver == "nvidia") config.services.xserver.videoDrivers;
  };
}
