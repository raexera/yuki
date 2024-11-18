{
  libnotify,
  libcanberra-gtk3,
  wireplumber,
  writeShellScriptBin,
}:
writeShellScriptBin "volumectl" ''
  case "$1" in
  up)
    ${wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ "$2%+"
    ;;
  down)
    ${wireplumber}/bin/wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ "$2%-"
    ;;
  toggle-mute)
    ${wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    ;;
  toggle-mic-mute)
    ${wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
    ;;
  esac

  volume_percentage="$(${wireplumber}/bin/wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')"
  isMuted="$(${wireplumber}/bin/wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o 'MUTED')"
  micMuted="$(${wireplumber}/bin/wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -o 'MUTED')"

  if [ "$1" = "toggle-mic-mute" ]; then
    if [ -n "$micMuted" ]; then
      ${libnotify}/bin/notify-send -u normal -a "VOLUMECTL" "Microphone Muted" -i microphone-sensitivity-muted-symbolic
    else
      ${libnotify}/bin/notify-send -u normal -a "VOLUMECTL" "Microphone Unmuted" -i microphone-sensitivity-high-symbolic
    fi
  else
    if [ -n "$isMuted" ]; then
      ${libnotify}/bin/notify-send -u normal -a "VOLUMECTL" "Volume Muted" -i audio-volume-muted-symbolic
    else
      ${libnotify}/bin/notify-send -u normal -a "VOLUMECTL" "Volume: $volume_percentage%" \
        -h string:x-canonical-private-synchronous:volumectl \
        -h int:value:"$volume_percentage" \
        -i audio-volume-high-symbolic

      ${libcanberra-gtk3}/bin/canberra-gtk-play -i audio-volume-change -d "volumectl"
    fi
  fi
''
