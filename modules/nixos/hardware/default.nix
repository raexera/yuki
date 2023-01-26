{config, ...}: {
  imports = [
    ./nvidia-offload.nix
    ./nvidia-sync.nix
  ];
}
