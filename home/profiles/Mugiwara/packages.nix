{pkgs, ...}: {
  programs = {
    home-manager.enable = true;

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
      ];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
