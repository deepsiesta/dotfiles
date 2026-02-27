{
  flake.modules.nixos.aagl = {inputs, ...}: {
    imports = [inputs.aagl.nixosModules.default];
    programs = {
      anime-game-launcher.enable = true;
      honkers-railway-launcher.enable = true;
      honkers-railway-launcher.package = inputs.aagl.packages.x86_64-linux.honkers-railway-launcher.override {extraPkgs = pkgs: [pkgs.winetricks];};
    };
  };
}
