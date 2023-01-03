{ self, inputs, ... }:
{
  modules = with inputs; [ ];
  exportedModules = [
    ./menu.nix
  ];
}

