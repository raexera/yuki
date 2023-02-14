{pkgs, ...}:
with pkgs;
  [
    (python3.withPackages (p:
      with p; [
        pygobject3
      ]))
  ]
  ++ [
    gobject-introspection
    pipenv
  ]
