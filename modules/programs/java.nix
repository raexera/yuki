{pkgs, ...}: {
  programs.java = {
    enable = true;
    package = pkgs.jdk17;
  };
}
