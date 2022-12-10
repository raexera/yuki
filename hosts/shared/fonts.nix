{
  pkgs,
  lib,
  ...
}: {
  fonts = {
    fonts = lib.attrValues {
      inherit
        (pkgs)
        emacs-all-the-icons-fonts
        inter
        material-icons
        material-design-icons
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        sf-mono-liga
        twemoji-color-font
        ;
    };

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Noto Serif" "Noto Color Emoji"];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        monospace = ["Liga SFMono Nerd Font" "Noto Color Emoji"];
        emoji = ["Noto Color Emoji"];
      };
    };
  };
}
