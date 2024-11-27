{
  config,
  lib,
  ...
}: {
  boot = lib.mkIf config.services.tlp.enable {
    kernelModules = ["acpi_call"];
    extraModulePackages = with config.boot.kernelPackages; [acpi_call];
  };
}
