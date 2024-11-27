{pkgs, ...}: {
  home.packages = with pkgs; [
    (python3.withPackages (ps:
      with ps; [
        pip
        virtualenv
      ]))

    pipenv
  ];
}
