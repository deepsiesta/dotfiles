{
  flake.modules.nixos.development = {
    inputs,
    pkgs,
    ...
  }: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    environment.systemPackages = [
      pkgs.vscodium-fhs
      inputs.llm-agents.packages.${system}.opencode
    ];
  };
}
