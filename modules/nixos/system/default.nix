{lib, ...}: {
  imports = [
    ./environment
    ./misc
    ./networking
    ./nix
    ./programs
    ./security
    ./services
    ./users
  ];

  system.stateVersion = lib.mkDefault "23.11";
}
