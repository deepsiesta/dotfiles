{
  flake.modules.nixos.cursor = {
    inputs,
    pkgs,
    ...
  }: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    environment.systemPackages = [
      pkgs.code-cursor-fhs
      inputs.llm-agents.packages.${system}.cursor-agent
    ];
  };
}
