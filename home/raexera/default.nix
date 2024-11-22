{lib, ...}: {
  imports = [
    ./config
    ./dev
    ./programs
    ./services
    ./shell
    ./window-managers/hyprland

    ./home.nix
    ../modules/theme
  ];

  # Catppuccin v0.1.3
  theme = {
    colorscheme = rec {
      colors = {
        rosewater = "F5E0DC";
        flamingo = "F2CDCD";
        pink = "F5C2E7";
        mauve = "DDB6F2";
        red = "F28FAD";
        maroon = "E8A2AF";
        peach = "F8BD96";
        yellow = "FAE3B0";
        green = "ABE9B3";
        teal = "B5E8E0";
        blue = "96CDFB";
        sky = "89DCEB";
        lavender = "C9CBFF";
        black0 = "0D1416"; # crust
        black1 = "111719"; # mantle
        black2 = "131A1C"; # base
        black3 = "192022"; # surface0
        black4 = "202729"; # surface1
        gray0 = "363D3E"; # surface2
        gray1 = "4A5051"; # overlay0
        gray2 = "5C6262"; # overlay1
        white = "C5C8C9"; # text
      };

      xcolors = lib.mapAttrsRecursive (_: color: "#${color}") colors;
    };

    wallpaper = ./wallpapers/chifuri-wallpaper.jpg;
  };

  wayland.windowManager.hyprland.settings = {
    monitor = [
      # name, resolution, position, scale
      "eDP-1, preferred, auto, 1.600000"
    ];

    device = let
      # Generated using https://gist.github.com/fufexan/e6bcccb7787116b8f9c31160fc8bc543
      accelpoints = "0.000 0.053 0.115 0.189 0.280 0.391 0.525 0.687 0.880 1.108 1.375 1.684 2.040 2.446 2.905 3.422 4.000 4.643 5.355 6.139";
    in [
      {
        name = "pnp0c50:00-06cb:cec0-touchpad";
        accel_profile = "custom ${accelpoints}";
        scroll_points = accelpoints;
        natural_scroll = true;
      }
      {
        name = "cust0000:00-27c6:0123";
        enabled = false;
      }
    ];
  };
}
