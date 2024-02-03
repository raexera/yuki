{
  lib,
  pkgs,
  ...
}: {
  programs.bash = {
    promptInit = ''eval "$(${lib.getExe pkgs.starship} init bash)"'';
  };
}
