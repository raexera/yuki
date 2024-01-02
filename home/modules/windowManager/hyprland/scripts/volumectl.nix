_: ''
  #!/usr/bin/env sh

  adjust_volume() {
      if [ "$1" = "up" ]; then
          pamixer -i 5
      else
          pamixer -d 5
      fi

      volume=$(pamixer --get-volume)
      dunstify -a "VOLUMECTL" "Volume: " -h int:value:"$volume" -i "$2" -r 2593 -u normal
      canberra-gtk-play -i dialog-error -d "error"
  }

  toggle_mute() {
      muted=$(pamixer "$([ "$1" = "mic" ] && echo "--default-source")" --get-mute)
      pamixer "$([ "$1" = "mic" ] && echo "--default-source")" --toggle-mute

      dunstify -a "VOLUMECTL" "$([ "$muted" = "true" ] && echo "UNMUTED" || echo "MUTED")" -i "$([ "$muted" = "true" ] && echo "$3" || echo "$2")" -r 2593 -u normal
  }

  case "$1" in
  up)
      adjust_volume up audio-volume-high-symbolic
      ;;
  down)
      adjust_volume down audio-volume-low-symbolic
      ;;
  mute)
      toggle_mute volume audio-volume-muted-symbolic audio-volume-high-symbolic
      ;;
  mic_mute)
      toggle_mute mic microphone-sensitivity-muted-symbolic microphone-sensitivity-high-symbolic
      ;;
  esac
''
