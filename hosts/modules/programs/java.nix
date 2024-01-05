{pkgs, ...}: {
  programs = {
    less.enable = true;
    ssh.startAgent = true;

    java = {
      enable = true;
      package = pkgs.jre;
    };

    bash.promptInit = ''eval "$(${pkgs.starship}/bin/starship init bash)"'';

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting = {
        enable = true;
        styles = {"alias" = "fg=magenta";};
        highlighters = ["main" "brackets" "pattern"];
      };
    };
  };
}
