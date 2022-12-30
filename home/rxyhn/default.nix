{
  config,
  outputs,
  pkgs,
  lib,
  ...
}: {
  imports =
    [
      ./home.nix
      ./packages.nix

      ./modules/shell

      ./modules/programs/discord.nix
      ./modules/programs/firefox.nix
      ./modules/programs/helix.nix
      ./modules/programs/kitty.nix
      ./modules/programs/wezterm.nix
      ./modules/programs/mpd.nix
      ./modules/programs/obs-studio.nix
      ./modules/programs/vscode.nix
      ./modules/programs/zathura.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  modules.hm = {
    windowManager.awesome = {
      enable = true;
      dpi = 192;
    };
  };
}
