{
  config,
  pkgs,
  ...
}: {
  programs.wofi = {
    enable = true;
    settings = {
      width = "60%";
      height = "40%";
      prompt = "";
      allow_images = true;
      allow_markup = true;
      exec_search = true;
      hide_scroll = true;
      insensitive = true;
      location = "center";
      columns = 3;
      gtk_dark = true;
      orientation = "vertical";
      image_size = 48;
      layer = "top";
    };
    style = let
      xcolors = pkgs.lib.colors.xcolors config.colorscheme.colors;
    in ''
      * {
        all: initial;
        font-family: Dosis;
        font-size: 1rem;
        background: transparent;
      }

      #window {
        background: alpha(${xcolors.background}, 0.2);
        border-radius: 12px;
      }

      #input {
        border-radius: 12px;
        border: 1px solid alpha(${xcolors.color4}, 0.8);
        background: alpha(${xcolors.background}, 0.2);
        padding: 0.75em;
        margin-bottom: 1.5em;
      }

      #outer-box {
        padding: 1.5em;
      }

      #text {
        margin: 0.25em;
        color: alpha(${xcolors.foreground}, 0.8);
      }

      #img {
        background: transparent;
        margin: 0.5em;
      }

      #entry {
        border-radius: 12px;
        background: transparent;
      }

      #entry:selected {
        background: alpha(${xcolors.background}, 0.2);
        font-weight: bold;
      }
    '';
  };
}
