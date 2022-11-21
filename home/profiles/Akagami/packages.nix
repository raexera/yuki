{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;
  home = {
    packages = with pkgs; [
      wezterm
    ];
  };
}
