{inputs, ...}: {
  imports = [inputs.aagl.nixosModules.default];
  programs = {
    anime-game-launcher.enable = true;
    honkers-railway-launcher.enable = true;
  };
}
