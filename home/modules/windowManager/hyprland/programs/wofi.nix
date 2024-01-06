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
      @define-color Background ${xcolors.base00};
      @define-color Foreground ${xcolors.base05};
      @define-color Accent ${xcolors.base0C};

      * {
        all: initial;
        font-family: Dosis;
        font-size: 1rem;
        background: transparent;
      }

      #window {
        background: alpha(@Background, 0.2);
        border-radius: 12px;
      }

      #input {
        border-radius: 12px;
        border: 1px solid alpha(@Accent, 0.8);
        background: alpha(@Background, 0.2);
        padding: 0.75em;
        margin-bottom: 1.5em;
      }

      #outer-box {
        padding: 1.5em;
      }

      #text {
        margin: 0.25em;
        color: alpha(@Foreground, 0.8);
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
        background: alpha(@Background, 0.2);
        font-weight: bold;
      }
    '';
  };
}
