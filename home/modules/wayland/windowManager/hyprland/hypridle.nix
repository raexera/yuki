{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  suspendScript = pkgs.writeShellScript "suspend-script" ''
    ${pkgs.pipewire}/bin/pw-cli i all | ${pkgs.ripgrep}/bin/rg running
    if [ $? == 1 ]; then
      ${pkgs.systemd}/bin/systemctl suspend
    fi
  '';
in {
  imports = [
    inputs.hypridle.homeManagerModules.hypridle
  ];

  services.hypridle = {
    enable = true;

    listeners = [
      {
        timeout = 600;
        onTimeout = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms off";
        onResume = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl dispatch dpms on";
      }
      {
        timeout = 900;
        onTimeout = suspendScript.outPath;
      }
    ];

    lockCmd = lib.meta.getExe config.programs.hyprlock.package;
    beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
  };
}
