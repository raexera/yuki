{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      onlyoffice-bin
      vim
      gtk3
      gdk-pixbuf
      librsvg
      youtube-music
      discord
      tdesktop
      zoom-us
    ];
  };
}
