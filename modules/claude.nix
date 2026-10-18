{
  flake.modules.nixos.claude = {
    inputs,
    pkgs,
    ...
  }: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    environment.systemPackages = [
      inputs.llm-agents.packages.${system}.claude-code
    ];
  };
}
