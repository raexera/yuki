{...}: {
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "suspend";
        action = "";
        text = "";
        keybind = "u";
      }
      {
        label = "lock";
        action = "";
        text = "";
        keybind = "l";
      }
      {
        label = "logout";
        action = "";
        text = "";
        keybind = "e";
      }
      {
        label = "reboot";
        action = "";
        text = "";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "";
        text = "";
        keybind = "s";
      }
    ];
    # style = ''
    # '';
  };
}
