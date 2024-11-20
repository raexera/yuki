{
  inputs,
  self,
  themes,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.raexera = import "${self}/home/raexera";
    extraSpecialArgs = {inherit inputs self themes;};
  };
}
