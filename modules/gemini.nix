{
  flake.modules.nixos.gemini = {
    pkgs,
    inputs,
    ...
  }: {
    nixpkgs.overlays = [inputs.llm-agents.overlays.default];

    environment.systemPackages = with pkgs; [
      antigravity-fhs
      llm-agents.gemini-cli
    ];
  };
}
