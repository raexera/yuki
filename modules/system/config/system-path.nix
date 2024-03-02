{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      git
      neovim
      starship
      vim
      warp-terminal
    ];
  };
}
