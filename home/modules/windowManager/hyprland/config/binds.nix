{
  config,
  pkgs,
  ...
}: let
  screenshotarea = "hyprctl keyword animation 'fadeOut,0,0,default'; grimblast --notify copysave area; hyprctl keyword animation 'fadeOut,1,4,default'";

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

  terminal = config.home.sessionVariables.TERMINAL;
  browser = config.home.sessionVariables.BROWSER;
  editor = config.home.sessionVariables.EDITOR;
in {
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";

      bind = let
        monocle = "dwindle:no_gaps_when_only";
      in
        [
          "$mod SHIFT, Q, exec, pkill Hyprland"
          "$mod, Q, killactive,"
          "$mod, F, fullscreen,"
          "$mod, G, togglegroup,"
          "$mod SHIFT, N, changegroupactive, f"
          "$mod SHIFT, P, changegroupactive, b"
          "$mod, R, togglesplit,"
          "$mod, T, togglefloating,"
          "$mod, P, pseudo,"
          "$mod ALT, ,resizeactive,"
          "$mod, M, exec, hyprctl keyword ${monocle} $(($(hyprctl getoption ${monocle} -j | jaq -r '.int') ^ 1))"

          "$mod, Space, exec, run-as-service $(wofi -S drun)"
          "$mod, Return, exec, run-as-service ${terminal}"
          "$mod, B, exec, ${browser}"
          "$mod, E, exec, ${editor}"
          "$mod, L, exec, ${pkgs.swaylock-effects}/bin/swaylock --grace 2"
          "$mod, O, exec, run-as-service wl-ocr"

          ", Print, exec, ${screenshotarea}"
          "CTRL, Print, exec, grimblast --notify --cursor copysave output"
          "ALT, Print, exec, grimblast --notify --cursor copysave screen"

          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          "$mod SHIFT, grave, movetoworkspace, special"
          "$mod, grave, togglespecialworkspace, eDP-1"

          "$mod, bracketleft, workspace, m-1"
          "$mod, bracketright, workspace, m+1"
        ]
        ++ workspaces;

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      binde = [
        ",XF86AudioRaiseVolume, exec, volumectl up 5"
        ",XF86AudioLowerVolume, exec, volumectl down 5"
        ",XF86AudioMute, exec, volumectl toggle-mute"

        ",XF86MonBrightnessUp, exec, lightctl up 5"
        ",XF86MonBrightnessDown, exec, lightctl down 5"
      ];
    };
    extraConfig = ''
      bind = $mod, S, submap, resize

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
