{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [./nix.nix];

  console = let
    normal = ["1E1E2E" "F38BA8" "A6E3A1" "F9E2AF" "89B4FA" "F5C2E7" "94E2D5" "BAC2DE"];
    bright = ["313244" "F38BA8" "A6E3A1" "F9E2AF" "89B4FA" "F5C2E7" "94E2D5" "A6ADC8"];
  in {
    colors = normal ++ bright;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
  };

  i18n = {
    defaultLocale = lib.mkDefault "en_US.UTF-8";

    extraLocaleSettings = {
      LC_TIME = lib.mkDefault "en_US.UTF-8";
    };

    supportedLocales = lib.mkDefault [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
  };

  networking = {
    networkmanager = {
      enable = true;
      unmanaged = ["docker0" "rndis0"];
      wifi.macAddress = "random";
    };

    firewall = {
      enable = true;
      allowPing = false;
      logReversePathDrops = true;
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  time = {
    timeZone = lib.mkDefault "Asia/Jakarta";
    hardwareClockInLocalTime = true;
  };
}
