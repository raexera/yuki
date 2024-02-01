{
  config,
  lib,
  pkgs,
  ...
}: let
  ocrScript = let
    inherit (pkgs) grim libnotify slurp tesseract5 wl-clipboard;
    _ = lib.getExe;
  in
    pkgs.writeShellScriptBin "wl-ocr" ''
      ${_ grim} -g "$(${_ slurp})" -t ppm - | ${_ tesseract5} - - | ${wl-clipboard}/bin/wl-copy
      ${_ libnotify} "$(${wl-clipboard}/bin/wl-paste)"
    '';

  screenshotarea = "hyprctl keyword animation 'fadeOut,0,0,default'; grimblast --notify copysave area; hyprctl keyword animation 'fadeOut,1,4,default'";

  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "SUPER, ${ws}, workspace, ${toString (x + 1)}"
        "SUPERSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    )
    10);

  gtk-launch = "${pkgs.gtk3}/bin/gtk-launch";
  xdg-mime = "${pkgs.xdg-utils}/bin/xdg-mime";
  defaultApp = type: "${gtk-launch} $(${xdg-mime} query default ${type})";

  terminal = config.home.sessionVariables.TERMINAL;
  browser = defaultApp "x-scheme-handler/https";
  editor = defaultApp "text/plain";
in {
  home.packages = [ocrScript];

  wayland.windowManager.hyprland = {
    settings = {
      bind = let
        monocle = "dwindle:no_gaps_when_only";
      in
        [
          "SUPERSHIFT, Q, exec, pkill Hyprland"
          "SUPER, Q, killactive,"

          "SUPER, S, togglesplit,"
          "SUPER, F, fullscreen,"
          "SUPER, P, pseudo,"
          "SUPER, M, exec, hyprctl keyword ${monocle} $(($(hyprctl getoption ${monocle} -j | jaq -r '.int') ^ 1))"
          "SUPER, Space, togglefloating,"
          "SUPERALT, ,resizeactive,"

          "SUPER, G, togglegroup,"
          "SUPERSHIFT, N, changegroupactive, f"
          "SUPERSHIFT, P, changegroupactive, b"

          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"

          "SUPERSHIFT, grave, movetoworkspace, special"
          "SUPER, grave, togglespecialworkspace, eDP-1"

          "SUPER, bracketleft, workspace, m-1"
          "SUPER, bracketright, workspace, m+1"

          "SUPER, Return, exec, run-as-service ${terminal}"
          "SUPER, B, exec, ${browser}"
          "SUPER, E, exec, ${editor}"
          "SUPER, L, exec, ${pkgs.systemd}/bin/loginctl lock-session"
          "SUPER, O, exec, run-as-service wl-ocr"

          ", Print, exec, ${screenshotarea}"
          "CTRL, Print, exec, grimblast --notify --cursor copysave output"
          "ALT, Print, exec, grimblast --notify --cursor copysave screen"
        ]
        ++ workspaces;

      bindr = [
        "SUPER, SUPER_L, exec, pkill .anyrun-wrapped || run-as-service anyrun"
      ];

      binde = [
        ",XF86AudioRaiseVolume, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume raise"
        ",XF86AudioLowerVolume, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume lower"
        ",XF86AudioMute, exec, ${pkgs.swayosd}/bin/swayosd-client --output-volume mute-toggle"
        ",XF86AudioMicMute, exec, ${pkgs.swayosd}/bin/swayosd-client --input-volume mute-toggle"

        ",XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set +5%"
        ",XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 5%-"
      ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
        "SUPER ALT, mouse:272, resizewindow"
      ];
    };

    extraConfig = ''
      bind = SUPERSHIFT, S, submap, resize

      submap=resize
      binde=,right,resizeactive,10 0
      binde=,left,resizeactive,-10 0
      binde=,up,resizeactive,0 -10
      binde=,down,resizeactive,0 10
      bind=,escape,submap,reset
      submap=reset
    '';
  };
}
