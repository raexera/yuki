{pkgs, ...}:
with pkgs;
  [
    (python3.withPackages (p:
      with p; [
        matplotlib
        numpy
        pandas
        pygobject3
        pytorch
        scikit-learn
        scipy
        seaborn
        sympy
        tensorflow
      ]))
  ]
  ++ [
    gobject-introspection
    pipenv
  ]
