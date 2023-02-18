{pkgs, ...}: {
  imports = [./nix.nix];

  console = let
    normal = ["1E1E2E" "F38BA8" "A6E3A1" "F9E2AF" "89B4FA" "F5C2E7" "94E2D5" "BAC2DE"];
    bright = ["313244" "F38BA8" "A6E3A1" "F9E2AF" "89B4FA" "F5C2E7" "94E2D5" "A6ADC8"];
  in {
    colors = normal ++ bright;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    useXkbConfig = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings.LC_TIME = "en_US.UTF-8";

    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
    ];
  };

  time = {
    timeZone = "Asia/Jakarta";
    hardwareClockInLocalTime = true;
  };
}
