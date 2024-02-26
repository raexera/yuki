{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      git
      starship
      vim
      neovim
    ];
  };
}
