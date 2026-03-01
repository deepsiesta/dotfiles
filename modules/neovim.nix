{
  flake.modules.nixos.neovim = {
    pkgs,
    inputs,
    ...
  }: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    environment.systemPackages = [
      inputs.nvim.packages.${system}.default
    ];
  };
}
