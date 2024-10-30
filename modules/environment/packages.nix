{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      onlyoffice-bin
      vim
      git
      gtk3
      gdk-pixbuf
      librsvg
      youtube-music
      discord
      tdesktop
      zoom-us
      brave
    ];
  };
}
