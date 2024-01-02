{...}: {
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "loginctl lock-session";
        text = "";
        keybind = "l";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit 0";
        text = "";
        keybind = "e";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "";
        keybind = "u";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "";
        keybind = "h";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "";
        keybind = "s";
      }
    ];

    style = ''
      @define-color Foreground #ffffff;
      @define-color Background #000000;
      @define-color Accent #88c0d0;

      * {
        all: initial;
        font-family: "tabler-icons";
        font-size: 96pt;
      }

      window {
        background-color: alpha(@Background, 0.2);
      }

      button {
        background-color: alpha(@Background, 0.2);
        border: 3px solid alpha(@Background, 0.2);
        border-radius: 8px;
        margin: 1rem;
        transition: all 0.3s ease-in-out;
      }

      button:focus,
      button:active,
      button:hover {
        background-color: alpha(@Accent, 0.8);
        border: 3px solid @Accent;
        box-shadow: 0 0 10px alpha(@Accent, 0.4), 0 0 20px alpha(@Accent, 0.4),
          0 0 40px alpha(@Accent, 0.4), 0 0 60px alpha(@Accent, 0.4);
        transition: all 0.5s ease-in-out;
        animation: neonGlow 1s ease-in-out infinite alternate;
      }

      button label {
        padding: 50px;
        color: alpha(@Foreground, 0.2);
      }

      button:hover label,
      button:focus label,
      button:active label {
        color: alpha(@Foreground, 0.8);
      }

      @keyframes neonGlow {
        from {
          box-shadow: 0 0 10px alpha(@Accent, 0.4), 0 0 20px alpha(@Accent, 0.4),
            0 0 40px alpha(@Accent, 0.4), 0 0 60px alpha(@Accent, 0.4);
        }
        to {
          box-shadow: 0 0 15px alpha(@Accent, 0.8), 0 0 30px alpha(@Accent, 0.8),
            0 0 60px alpha(@Accent, 0.8), 0 0 90px alpha(@Accent, 0.8);
        }
      }
    '';
  };
}
