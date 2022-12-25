{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.nixos.virtualisation.docker;
in {
  options.modules.nixos.virtualisation.docker = {
    enable = mkEnableOption "Enable The Docker Daemon";

    enableNvidia = mkOption {
      type = types.bool;
      default = false;
      description = "Enable NVIDIA Support";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      docker-client
      docker-compose
      docker-credential-helpers
    ];

    virtualisation.docker = {
      enable = true;
      enableNvidia = cfg.enableNvidia;
    };
  };
}
