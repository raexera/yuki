{lib, ...}: {
  location.provider = "geoclue2";
  services.geoclue2.enable = true;

  time = {
    timeZone = lib.mkDefault "Asia/Jakarta";
    hardwareClockInLocalTime = lib.mkDefault true;
  };
}
