{
  lib,
  pkgs,
  ...
}: ''
  #!/usr/bin/env sh

  send_notification() {
      brightness_percentage=$(($(${lib.getExe pkgs.brightnessctl} -q g) * 100 / $(${lib.getExe pkgs.brightnessctl} -q m)))
      brightness_percentage=$((brightness_percentage < 0 ? 0 : brightness_percentage > 100 ? 100 : brightness_percentage))

      ${pkgs.dunst}/bin/dunstify -a "LIGHTCTL" "Brightness: " -h int:value:"$brightness_percentage" -i display-brightness-symbolic -r 2593 -u normal
  }

  case "$1" in
  up)
      ${lib.getExe pkgs.brightnessctl} -q set +5%
      send_notification
      ;;
  down)
      ${lib.getExe pkgs.brightnessctl} -q set 5%-
      send_notification
      ;;
  esac
''
