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
    style = ''
      * {
        font-family: Dosis;
        background: transparent;
      }

      #window {
        background: rgba(255, 255, 255, 0.2);
        border-radius: 12px;
      }

      #input {
        border-radius: 12px;
        border: 1px solid rgba(0, 0, 0, 0.2);
        background: rgba(255, 255, 255, 0.2);
        padding: 8px;
        margin-bottom: 24px;
      }

      #outer-box {
        padding: 24px;
      }

      #text {
        margin: 4px;
        color: rgba(0, 0, 0, 0.6);
      }

      #img {
        background: transparent;
        margin: 8px;
      }

      #entry {
        border-radius: 12px;
        background: transparent;
      }

      #entry:selected {
        background: rgba(255, 255, 255, 0.2);
        font-weight: bold;
      }
    '';
  };
}
