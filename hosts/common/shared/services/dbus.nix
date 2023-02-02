{pkgs, ...}: {
  services.dbus = {
    enable = true;
    packages = with pkgs; [dconf gcr];
  };
}
