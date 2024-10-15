{
  lib,
  pkgs,
  ...
}: let
  # binds SUPER + [shift +] {1..10} to [move to] workspace {1..10}
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "SUPER, ${ws}, workspace, ${toString (x + 1)}"
        "SUPER SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    )
    10);

  toggle = program: service: let
    prog = builtins.substring 0 14 program;
    runserv = lib.optionalString service "run-as-service";
  in "pkill ${prog} || ${runserv} ${program}";

  runOnce = program: "pgrep ${program} || ${program}";
in {
  wayland.windowManager.hyprland = {
    settings = {
      bind = let
        monocle = "dwindle:no_gaps_when_only";

        # default application
        defaultApp = type: "${pkgs.gtk3}/bin/gtk-launch $(${pkgs.xdg-utils}/bin/xdg-mime query default ${type})";
        browser = defaultApp "x-scheme-handler/https";
        editor = defaultApp "text/plain";
      in
        [
          # compositor commands
          "SUPERSHIFT, E, exec, pkill Hyprland"
          "SUPER, Q, killactive"
          "SUPER, S, togglesplit"
          "SUPER, F, fullscreen"
          "SUPER, P, pseudo"
          "SUPERSHIFT, P, pin"
          "SUPER, Space, togglefloating"
          "SUPERALT, ,resizeactive,"

          # toggle "monocle" (no_gaps_when_only)
          "SUPER, M, exec, hyprctl keyword ${monocle} $(($(hyprctl getoption ${monocle} -j | jaq -r '.int') ^ 1))"

          # grouped (tabbed) windows
          "SUPER, G, togglegroup"
          "SUPER, TAB, changegroupactive, f"
          "SUPERSHIFT, TAB, changegroupactive, b"

          # cycle through windows
          "ALT, Tab, cyclenext"
          "ALT, Tab, bringactivetotop"
          "ALTSHIFT, Tab, cyclenext, prev"
          "ALTSHIFT, Tab, bringactivetotop"

          # move focus
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"

          # move windows
          "SUPERSHIFT, left, movewindow, l"
          "SUPERSHIFT, right, movewindow, r"
          "SUPERSHIFT, up, movewindow, u"
          "SUPERSHIFT, down, movewindow, d"

          # special workspaces
          "SUPERSHIFT, grave, movetoworkspace, special"
          "SUPER, grave, togglespecialworkspace, eDP-1"

          # cycle workspaces
          "SUPER, bracketleft, workspace, m-1"
          "SUPER, bracketright, workspace, m+1"

          # cycle monitors
          "SUPERSHIFT, bracketleft, focusmonitor, l"
          "SUPERSHIFT, bracketright, focusmonitor, r"

          # send focused workspace to left/right monitors
          "SUPERSHIFT ALT, bracketleft, movecurrentworkspacetomonitor, l"
          "SUPERSHIFT ALT, bracketright, movecurrentworkspacetomonitor, r"

          # utilities
          "SUPER, Return, exec, run-as-service kitty"
          "SUPER, B, exec, ${browser}"
          "SUPER, E, exec, ${editor}"
          "SUPER, O, exec, ${runOnce "wl-ocr"}"
          "SUPER, L, exec, pgrep hyprlock || hyprlock"

          # screenshot
          ", Print, exec, ${runOnce "grimblast"} --notify copysave area"
          "CTRL, Print, exec, ${runOnce "grimblast"} --notify --cursor copysave output"
          "ALT, Print, exec, ${runOnce "grimblast"} --notify --cursor copysave screen"
        ]
        ++ workspaces;

      bindr = [
        # launcher
        "SUPER, SUPER_L, exec, ${toggle "anyrun" true}"
      ];

      bindle = [
        # audio
        ",XF86AudioRaiseVolume, exec, volumectl up 5"
        ",XF86AudioLowerVolume, exec, volumectl down 5"
        ",XF86AudioMute, exec, volumectl toggle-mute"
        ",XF86AudioMicMute, exec, ${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute"

        # brightness
        ",XF86MonBrightnessUp, exec, lightctl up 5"
        ",XF86MonBrightnessDown, exec, lightctl down 5"
      ];

      # mouse bindings
      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
        "SUPER ALT, mouse:272, resizewindow"
      ];
    };

    # configure submaps
    extraConfig = ''
      bind = SUPERSHIFT, S, submap, resize

      submap = resize
      binde = , right, resizeactive, 10 0
      binde = , left, resizeactive, -10 0
      binde = , up, resizeactive, 0 -10
      binde = , down, resizeactive, 0 10
      bind = , escape, submap, reset
      submap = reset
    '';
  };
}
