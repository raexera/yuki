{pkgs, ...}: {
  programs = {
    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';

    java = {
      enable = true;
      package = pkgs.jre;
    };

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting = {
        enable = true;
        styles = {"alias" = "fg=magenta";};
        highlighters = ["main" "brackets" "pattern"];
      };
    };

    dconf.enable = true;
    kdeconnect.enable = true;
    seahorse.enable = true;
  };
}
