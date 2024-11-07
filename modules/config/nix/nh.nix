{
  programs.nh = {
    enable = true;
    flake = "/home/raexera/.yuki";

    clean = {
      enable = true;
      extraArgs = "--keep-since 1w";
    };
  };
}
