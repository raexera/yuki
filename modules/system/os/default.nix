{lib, ...}: {
  imports = [
    ./display
    ./environment
    ./misc
    ./networking
    ./programs
    ./security
    ./services
    ./users
  ];

  system.stateVersion = lib.mkDefault "23.11";
}
