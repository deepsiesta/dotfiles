{
  inputs,
  lib,
  ...
}: {
  imports = [inputs.aagl.nixosModules.default];
  nix.settings = inputs.aagl.nixConfig; # Set up Cachix
  programs = {
    anime-game-launcher.enable = true;
    honkers-railway-launcher.enable = true;
    sleepy-launcher.enable = true;
  };
}
