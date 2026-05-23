{
  flake.modules.nixos.development = {
    inputs,
    pkgs,
    ...
  }: {
    nixpkgs.overlays = [inputs.llm-agents.overlays.default];

    environment.systemPackages = with pkgs; [
      vscodium-fhs
      llm-agents.opencode
    ];
  };
}
