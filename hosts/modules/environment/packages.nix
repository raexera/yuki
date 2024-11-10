{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      # Communication
      zoom-us
      discord
      tdesktop

      # Media & Music
      youtube-music
      amberol
      celluloid
      imv
      loupe
      pavucontrol

      # Office & Reading
      onlyoffice-bin
      foliate
    ];
  };
}
