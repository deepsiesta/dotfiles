{
  flake.modules.nixos.gemini = {
    pkgs,
    inputs,
    ...
  }: {
    nixpkgs.overlays = [inputs.llm-agents.overlays.default];

    environment.systemPackages = with pkgs; [
      llm-agents.antigravity
    ];
  };
}
