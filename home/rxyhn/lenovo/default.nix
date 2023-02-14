{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Shared configuration
    ../shared
    ../shared/optional/programs/firefox.nix
    ../shared/optional/programs/helix.nix
    ../shared/optional/programs/mpd.nix
    ../shared/optional/programs/mpv.nix
    ../shared/optional/programs/obs-studio.nix
    ../shared/optional/programs/vscode.nix
    ../shared/optional/programs/wezterm.nix

    # Specific configuration
    ./desktop
    ./pkgs
    ./services
    ./X
  ];
}
