{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.nixos.virtualisation.libvirtd;
in {
  options.modules.nixos.virtualisation.libvirtd = {
    enable = mkEnableOption "Enable The Libvirt Virtualization Daemon";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.virt-manager];

    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        ovmf = {
          enable = true;
          packages = [pkgs.OVMFFull.fd];
        };
        swtpm.enable = true;
      };
    };
  };
}
