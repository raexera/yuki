{lib, ...}: {
  imports = [
    ./environment
    ./networking
    ./programs
    ./security
    ./users
  ];

  system.stateVersion = lib.mkDefault "23.11";
}
