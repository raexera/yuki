{ pkgs, ... }:

{
  home = {
    username = "rxyhn";
    homeDirectory = "/home/rxyhn";

    stateVersion = "22.05";

    packages = with pkgs; [
      firefox
      nixfmt
    ];
  };

  programs = {
    home-manager.enable = true;

    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "direnv" ];
        theme = "robbyrussell";
      };
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
    };

    vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
      ];
    };
  };
}