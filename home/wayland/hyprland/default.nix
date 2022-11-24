{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
with lib; let
  ocr = pkgs.writeShellScriptBin "ocr" ''
    #!/bin/bash
    grim -g "$(slurp -w 0 -b eebebed2)" /tmp/ocr.png && tesseract /tmp/ocr.png /tmp/ocr-output && wl-copy < /tmp/ocr-output.txt && notify-send "OCR" "Text copied!" && rm /tmp/ocr-output.txt -f
  '';
in {
  home.packages = with pkgs; [
    ocr
    grim
    pngquant
    python39Packages.requests
    slurp
    swayidle
    tesseract5
    wf-recorder
    wl-clipboard
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    xorg.xprop
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.default.override {
      nvidiaPatches = true;
      wlroots =
        inputs.hyprland.packages.${pkgs.system}.wlroots-hyprland.overrideAttrs
        (old: {
          patches =
            (old.patches or [])
            ++ [
              (pkgs.fetchpatch {
                url = "https://aur.archlinux.org/cgit/aur.git/plain/0001-nvidia-format-workaround.patch?h=hyprland-nvidia-screenshare-git";
                sha256 = "A9f1p5EW++mGCaNq8w7ZJfeWmvTfUm4iO+1KDcnqYX8=";
              })
            ];
        });
    };
    systemdIntegration = true;
    extraConfig = import ./config.nix;
  };

  services.gammastep = {
    enable = true;
    provider = "geoclue2";
  };

  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wayland wallpaper daemon";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg --mode fill --image ${./assets/wallpaper/nix-gradient.png}";
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };
}
