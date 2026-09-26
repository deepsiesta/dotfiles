{
  flake.modules.nixos.forge = {
    inputs,
    pkgs,
    ...
  }: {
    imports = [inputs.stable-diffusion-webui-nix.nixosModules.default];
    environment.systemPackages = [
      pkgs.stable-diffusion-webui.forge.cuda
    ];
  };
}
