{config, ...}: let
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    )
    10);
in {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bind = let
      monocle = "dwindle:no_gaps_when_only";
    in
      [
        # compositor commands
        "$mod SHIFT, E, exec, pkill Hyprland"
        "$mod, Q, killactive,"
        "$mod, F, fullscreen,"
        "$mod, G, togglegroup,"
        "$mod SHIFT, N, changegroupactive, f"
        "$mod SHIFT, P, changegroupactive, b"
        "$mod, R, togglesplit,"
        "$mod, T, togglefloating,"
        "$mod, P, pseudo,"
        "$mod ALT, ,resizeactive,"

        # toggle "monocle" (no_gaps_when_only)
        "$mod, M, exec, hyprctl keyword ${monocle} $(($(hyprctl getoption ${monocle} -j | jaq -r '.int') ^ 1))"

        # utility
        # terminal
        "$mod, Return, exec, run-as-service ${default.terminal.name}"
        # logout menu
        "$mod, Escape, exec, wlogout -p layer-shell"
        # lock screen
        "$mod, L, exec, loginctl lock-session"
        # select area to perform OCR on
        "$mod, O, exec, run-as-service wl-ocr"

        # move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # screenshot
        # stop animations while screenshotting; makes black border go away
        ", Print, exec, ${screenshotarea}"
        "$mod SHIFT, R, exec, ${screenshotarea}"

        "CTRL, Print, exec, grimblast --notify --cursor copysave output"
        "$mod SHIFT CTRL, R, exec, grimblast --notify --cursor copysave output"

        "ALT, Print, exec, grimblast --notify --cursor copysave screen"
        "$mod SHIFT ALT, R, exec, grimblast --notify --cursor copysave screen"

        # special workspace
        "$mod SHIFT, grave, movetoworkspace, special"
        "$mod, grave, togglespecialworkspace, eDP-1"

        # cycle workspaces
        "$mod, bracketleft, workspace, m-1"
        "$mod, bracketright, workspace, m+1"

        # cycle monitors
        "$mod SHIFT, bracketleft, focusmonitor, l"
        "$mod SHIFT, bracketright, focusmonitor, r"
      ]
      ++ workspaces;

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod ALT, mouse:272, resizewindow"
    ];

    binde = [
      ",XF86AudioRaiseVolume, exec, pamixer -i 5"
      ",XF86AudioLowerVolume, exec, pamixer -d 5"
      ",XF86AudioMute, exec, pamixer -t"

      ",XF86MonBrightnessUp, exec, brightnessctl set +10%"
      ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"
    ];
  };
}
