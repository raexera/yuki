{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  # use OCR and copy to clipboard
  ocrScript = let
    inherit (pkgs) grim libnotify slurp tesseract5 wl-clipboard;
    _ = lib.getExe;
  in
    pkgs.writeShellScriptBin "wl-ocr" ''
      ${_ grim} -g "$(${_ slurp})" -t ppm - | ${_ tesseract5} - - | ${wl-clipboard}/bin/wl-copy
      ${_ libnotify} "$(${wl-clipboard}/bin/wl-paste)"
    '';
in {
  imports = [
    inputs.hyprland.homeManagerModules.default

    ../../dunst
    ../../waybar
    ../../gtk.nix
    ../../rofi.nix
    ../../swaylock.nix
  ];

  home = {
    packages = with pkgs; [
      clipman
      grim
      ocrScript
      pngquant
      python39Packages.requests
      slurp
      swayidle
      tesseract5
      wf-recorder
      wl-clipboard
      xorg.xprop
      inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
      inputs.hyprpicker.packages.${pkgs.system}.hyprpicker
    ];

    sessionVariables = {
      NIXOS_OZONE_WL = "1";

      # XDG Specifications
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";

      # QT Variables
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_STYLE_OVERRIDE = "kvantum";
      DISABLE_QT5_COMPAT = "0";

      # NVIDIA Specific
      GBM_BACKEND = "nvidia-drm";
      LIBVA_DRIVER_NAME = "nvidia";
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
      WLR_DRM_NO_ATOMIC = "1";
      WLR_BACKEND = "vulkan";
      WLR_NO_HARDWARE_CURSORS = "1";
      WLR_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";

      # Toolkit Backend Variables
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";

      # Theming Related Variables
      GTK_THEME = "Catppuccin-Mocha-Standard-Mauve-Dark";
      XCURSOR_SIZE = "24";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default.override {nvidiaPatches = true;};
    systemdIntegration = true;
    extraConfig = import ./config.nix;
  };

  services.gammastep = {
    enable = true;
    provider = "geoclue2";
  };

  systemd.user.services.swaybg = let
    wallpaper = builtins.fetchurl rec {
      name = "wallpaper-${sha256}.png";
      url = "https://raw.githubusercontent.com/rxyhn/wallpapers/main/catppuccin/cat_leaves.png";
      sha256 = "1894y61nx3p970qzxmqjvslaalbl2skj5sgzvk38xd4qmlmi9s4i";
    };
  in {
    Unit = {
      Description = "Wayland wallpaper daemon";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg --mode fill --image ${wallpaper}";
      Restart = "on-failure";
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
