{
  libnotify,
  util-linux,
  writeShellScriptBin,
}:
writeShellScriptBin "networkctl" ''
  toggle_network() {
    wifi_state="$(${util-linux}/bin/rfkill list wifi | grep -i 'Soft blocked: yes' > /dev/null && echo "off" || echo "on")"
    bluetooth_state="$(${util-linux}/bin/rfkill list bluetooth | grep -i 'Soft blocked: yes' > /dev/null && echo "off" || echo "on")"

    if [ "$wifi_state" = "on" ] || [ "$bluetooth_state" = "on" ]; then
      ${util-linux}/bin/rfkill block wifi
      ${util-linux}/bin/rfkill block bluetooth
      ${libnotify}/bin/notify-send -u normal -a "NETWORKCTL" "Airplane Mode Enabled" "Wi-Fi and Bluetooth disabled" -i airplane-mode-symbolic
    else
      ${util-linux}/bin/rfkill unblock wifi
      ${util-linux}/bin/rfkill unblock bluetooth
      ${libnotify}/bin/notify-send -u normal -a "NETWORKCTL" "Airplane Mode Disabled" "Wi-Fi and Bluetooth enabled" -i airplane-mode-disabled-symbolic
    fi
  }

  case "$1" in
    toggle-network)
      toggle_network
      ;;
  esac
''
