{
  flake.modules.nixos.gemini = {
    inputs,
    pkgs,
    ...
  }: let
    inherit (pkgs.stdenv.hostPlatform) system;
  in {
    environment.systemPackages = [
      inputs.llm-agents.packages.${system}.antigravity-cli
    ];
  };
}
