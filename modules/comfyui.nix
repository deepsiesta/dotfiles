{
  flake.modules.nixos.comfyui = {
    inputs,
    pkgs,
    ...
  }: {
    nixpkgs.overlays = [inputs.comfyui-nix.overlays.default];

    environment.systemPackages = [
      pkgs.comfy-ui-cuda
    ];
  };
}
