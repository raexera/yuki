{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Shared configuration
    ../global/default
    ../global/optional/programs/firefox.nix
    ../global/optional/programs/helix.nix
    ../global/optional/programs/mpd.nix
    ../global/optional/programs/mpv.nix
    ../global/optional/programs/ncmpcpp.nix
    ../global/optional/programs/obs-studio.nix
    ../global/optional/programs/vscode.nix
    ../global/optional/programs/wezterm.nix

    # Self configuration
    ./desktop
    ./services
    ./X
    ./packages.nix
  ];
}
