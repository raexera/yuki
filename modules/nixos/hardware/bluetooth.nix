{pkgs, ...}: {
  bluetooth = {
    enable = true;
    package = pkgs.bluez5-experimental;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
    };
  };
}
