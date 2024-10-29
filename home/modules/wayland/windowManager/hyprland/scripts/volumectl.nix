{
  lib,
  pkgs,
  ...
}: let
  _ = lib.getExe;

  volumectl = let
    inherit (pkgs) libnotify pamixer libcanberra-gtk3;
  in
    pkgs.writeShellScriptBin "volumectl" ''
      #!/usr/bin/env bash

      case "$1" in
      up)
        ${_ pamixer} -i "$2"
        ;;
      down)
        ${_ pamixer} -d "$2"
        ;;
      toggle-mute)
        ${_ pamixer} -t
        ;;
      toggle-mic-mute)
        ${_ pamixer} --default-source -t
        ;;
      esac

      volume_percentage="$(${_ pamixer} --get-volume)"
      isMuted="$(${_ pamixer} --get-mute)"
      micMuted="$(${_ pamixer} --default-source --get-mute)"

      if [ "$1" = "toggle-mic-mute" ]; then
        if [ "$micMuted" = "true" ]; then
          ${libnotify}/bin/notify-send -u normal -a "VOLUMECTL" "Microphone Muted" -i microphone-sensitivity-muted-symbolic
        else
          ${libnotify}/bin/notify-send -u normal -a "VOLUMECTL" "Microphone Unmuted" -i microphone-sensitivity-high-symbolic
        fi
      else
        if [ "$isMuted" = "true" ]; then
          ${libnotify}/bin/notify-send -u normal -a "VOLUMECTL" "Volume Muted" -i audio-volume-muted-symbolic
        else
          ${libnotify}/bin/notify-send -u normal -a "VOLUMECTL" "Volume: $volume_percentage%" \
            -h string:x-canonical-private-synchronous:volumectl \
            -h int:value:"$volume_percentage" \
            -i audio-volume-high-symbolic

          ${libcanberra-gtk3}/bin/canberra-gtk-play -i audio-volume-change -d "volumectl"
        fi
      fi
    '';
in {
  home.packages = [
    volumectl
  ];
}
