{
  services.logind = {
    lidSwitch = "suspend-then-hibernate";
    lidSwitchExternalPower = "lock";
    extraConfig = ''
      HandlePowerKey=suspend-then-hibernate
      HibernateDelaySec=3600
    '';
  };
}
