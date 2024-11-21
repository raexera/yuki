{
  brightnessctl,
  libnotify,
  writeShellScriptBin,
}:
writeShellScriptBin "lightctl" ''
  case "$1" in
  up)
    ${brightnessctl}/bin/brightnessctl -q s "$2"%+
    ;;
  down)
    ${brightnessctl}/bin/brightnessctl -q s "$2"%-
    ;;
  esac

  brightness_percentage=$((($(${brightnessctl}/bin/brightnessctl g) * 100) / $(${brightnessctl}/bin/brightnessctl m)))
  ${libnotify}/bin/notify-send -u normal -a "LIGHTCTL" "Brightness: $brightness_percentage%"  \
    -h string:x-canonical-private-synchronous:lightctl \
    -h int:value:"$brightness_percentage" \
    -i display-brightness-symbolic
''
