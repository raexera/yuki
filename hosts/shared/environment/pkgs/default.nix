{
  pkgs,
  config,
  ...
}: let
  basic = import ./basic.nix {pkgs = pkgs;};
  core = import ./core.nix {pkgs = pkgs;};
  cliutils = import ./cliutils.nix {pkgs = pkgs;};
  guiutils = import ./guiutils.nix {pkgs = pkgs;};
  media = import ./media.nix {pkgs = pkgs;};
  pythonpackages = import ./python.nix {pkgs = pkgs;};
in {
  imports = [./fonts.nix];
  environment.systemPackages = with pkgs;
    [
      figlet
      pfetch
    ]
    ++ basic
    ++ core
    ++ guiutils
    ++ cliutils
    ++ media
    ++ pythonpackages;
}
