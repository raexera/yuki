{
  default,
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
      xcolors = pkgs.lib.colors.xcolors default.colorscheme.colors;
    in ''
      * {
        all: initial;
        font-family: Dosis;
        font-size: 1rem;
        background-color: transparent;
      }

      #window {
        background-color: ${xcolors.black0};
        border-radius: 12px;
      }

      #input {
        border-radius: 12px;
        border: 1px solid ${xcolors.mauve};
        background-color: ${xcolors.black3};
        padding: 0.75em;
        margin-bottom: 1.5em;
      }

      #outer-box {
        padding: 1.5em;
      }

      #text {
        margin: 0.25em;
        color: ${xcolors.white};
      }

      #img {
        background-color: transparent;
        margin: 0.5em;
      }

      #entry {
        border-radius: 12px;
        background-color: transparent;
      }

      #entry:selected {
        background-color: ${xcolors.black3};
        font-weight: bold;
      }
    '';
  };
}
