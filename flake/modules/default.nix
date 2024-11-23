{self, ...}: let
  mkFlakeModule = path:
    assert builtins.isPath path;
      import (self + path);
in {
  flake = {
    nixosModules = {
      config = mkFlakeModule /modules/nixos/config;
      hardware = mkFlakeModule /modules/nixos/hardware;
      security = mkFlakeModule /modules/nixos/security;
      system = mkFlakeModule /modules/nixos/system;
      users = mkFlakeModule /modules/nixos/users;
      windowManagers = mkFlakeModule /modules/nixos/windowManagers;
    };

    homeManagerModules = {
      theme = mkFlakeModule /modules/home/theme;
      windowManagers = mkFlakeModule /modules/home/windowManagers;
    };
  };
}
